const DEFAULT_CONFIG = {
    maxTotalWorkers: 3,
    maxFreeWorkers: 1,
    maxPerUser: 1,
    batchWindowMs: 3000,
    batchSize: 4,
};
class GenerationQueue {
    queue = [];
    activeJobs = new Map();
    activePerUser = new Map();
    activeFree = 0;
    timer = null;
    config;
    persistEnqueue;
    persistDequeue;
    constructor(config) {
        this.config = config;
    }
    setConfig(config) {
        this.config = config;
        this.schedule();
    }
    getConfig() {
        return { ...this.config };
    }
    setPersistence(enqueue, dequeue) {
        this.persistEnqueue = enqueue;
        this.persistDequeue = dequeue;
    }
    enqueue(job, options) {
        this.queue.push(job);
        if (options?.persist !== false) {
            this.persistEnqueue?.(job.id).catch(() => { });
        }
        this.schedule();
        return { position: this.getQueuePosition(job.id) };
    }
    getQueuePosition(jobId) {
        const index = this.queue.findIndex((job) => job.id === jobId);
        return index === -1 ? 0 : index + 1;
    }
    markJobFinished(jobId) {
        const job = this.activeJobs.get(jobId);
        if (!job)
            return;
        this.activeJobs.delete(jobId);
        const userCount = (this.activePerUser.get(job.userId) || 1) - 1;
        if (userCount <= 0)
            this.activePerUser.delete(job.userId);
        else
            this.activePerUser.set(job.userId, userCount);
        if (job.tier === 'free') {
            this.activeFree = Math.max(0, this.activeFree - 1);
        }
        this.persistDequeue?.(jobId).catch(() => { });
        this.schedule();
    }
    schedule() {
        if (this.timer)
            return;
        if (this.queue.length === 0)
            return;
        if (this.queue.length >= this.config.batchSize) {
            this.flush();
            return;
        }
        this.timer = setTimeout(() => this.flush(), this.config.batchWindowMs);
    }
    flush() {
        if (this.timer) {
            clearTimeout(this.timer);
            this.timer = null;
        }
        this.queue.sort((a, b) => this.calculatePriority(b) - this.calculatePriority(a));
        while (this.queue.length > 0 && this.canDispatchAny()) {
            const index = this.queue.findIndex((job) => this.canDispatch(job));
            if (index === -1)
                break;
            const job = this.queue.splice(index, 1)[0];
            this.dispatch(job);
        }
        if (this.queue.length > 0) {
            this.schedule();
        }
    }
    dispatch(job) {
        this.activeJobs.set(job.id, job);
        this.activePerUser.set(job.userId, (this.activePerUser.get(job.userId) || 0) + 1);
        if (job.tier === 'free') {
            this.activeFree += 1;
        }
        job.run().catch(() => {
            this.markJobFinished(job.id);
        });
    }
    calculatePriority(job) {
        const tierWeight = { free: 1, pro: 5, unlimited: 10 };
        const waitMinutes = (Date.now() - job.createdAt) / 60000;
        return tierWeight[job.tier] + waitMinutes;
    }
    canDispatch(job) {
        if (this.activeJobs.size >= this.config.maxTotalWorkers)
            return false;
        if (job.tier === 'free' && this.activeFree >= this.config.maxFreeWorkers)
            return false;
        const perUser = this.activePerUser.get(job.userId) || 0;
        if (perUser >= this.config.maxPerUser)
            return false;
        return true;
    }
    canDispatchAny() {
        return this.activeJobs.size < this.config.maxTotalWorkers;
    }
}
export const generationQueue = new GenerationQueue(DEFAULT_CONFIG);
