import { Router } from 'express';
import { authMiddleware } from '../middleware/auth.js';
import { getGradioClient } from '../services/gradio-client.js';
const router = Router();
// Local LoRA state tracking (Gradio doesn't have a dedicated status endpoint)
let loraState = {
    loaded: false,
    active: false,
    scale: 1.0,
    path: '',
};
// POST /api/lora/load — Load a LoRA adapter
router.post('/load', authMiddleware, async (req, res) => {
    try {
        const { lora_path } = req.body;
        if (!lora_path || typeof lora_path !== 'string') {
            res.status(400).json({ error: 'lora_path is required' });
            return;
        }
        const client = await getGradioClient();
        const result = await client.predict('/load_lora', [lora_path]);
        const status = result.data[0];
        loraState = { loaded: true, active: true, scale: loraState.scale, path: lora_path };
        res.json({ message: status, lora_path, loaded: true });
    }
    catch (error) {
        console.error('[LoRA] Load error:', error);
        res.status(500).json({ error: error instanceof Error ? error.message : 'Failed to load LoRA' });
    }
});
// POST /api/lora/unload — Unload the current LoRA adapter
router.post('/unload', authMiddleware, async (_req, res) => {
    try {
        const client = await getGradioClient();
        const result = await client.predict('/unload_lora', []);
        const status = result.data[0];
        loraState = { loaded: false, active: false, scale: 1.0, path: '' };
        res.json({ message: status });
    }
    catch (error) {
        console.error('[LoRA] Unload error:', error);
        res.status(500).json({ error: error instanceof Error ? error.message : 'Failed to unload LoRA' });
    }
});
// POST /api/lora/scale — Set LoRA scale (0.0 - 1.0)
router.post('/scale', authMiddleware, async (req, res) => {
    try {
        const { scale } = req.body;
        if (typeof scale !== 'number' || scale < 0 || scale > 1) {
            res.status(400).json({ error: 'scale must be a number between 0 and 1' });
            return;
        }
        const client = await getGradioClient();
        const result = await client.predict('/set_lora_scale', [scale]);
        const status = result.data[0];
        loraState.scale = scale;
        res.json({ message: status, scale });
    }
    catch (error) {
        console.error('[LoRA] Scale error:', error);
        res.status(500).json({ error: error instanceof Error ? error.message : 'Failed to set LoRA scale' });
    }
});
// POST /api/lora/toggle — Toggle LoRA on/off
router.post('/toggle', authMiddleware, async (req, res) => {
    try {
        const { enabled } = req.body;
        const useLoRA = typeof enabled === 'boolean' ? enabled : !loraState.active;
        const client = await getGradioClient();
        const result = await client.predict('/set_use_lora', [useLoRA]);
        const status = result.data[0];
        loraState.active = useLoRA;
        res.json({ message: status, active: useLoRA });
    }
    catch (error) {
        console.error('[LoRA] Toggle error:', error);
        res.status(500).json({ error: error instanceof Error ? error.message : 'Failed to toggle LoRA' });
    }
});
// GET /api/lora/status — Get current LoRA state
router.get('/status', authMiddleware, async (_req, res) => {
    res.json(loraState);
});
export default router;
