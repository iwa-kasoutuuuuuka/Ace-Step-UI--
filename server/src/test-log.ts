
import { appendFileSync } from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const LOG_FILE = path.join(__dirname, '../data/error.log');

function writeErrorLog(context: string, error: any, metadata?: any): void {
  try {
    const timestamp = new Date().toISOString();
    const errorMessage = error instanceof Error ? error.stack || error.message : String(error);
    const logEntry = `
[${timestamp}] ${context.toUpperCase()} ERROR
Message: ${errorMessage}
${metadata ? `Metadata: ${JSON.stringify(metadata, null, 2)}` : ''}
--------------------------------------------------------------------------------
`;
    appendFileSync(LOG_FILE, logEntry, 'utf-8');
    console.log(`[Test] Error logged to ${LOG_FILE}`);
  } catch (logErr) {
    console.error('[Test] Failed to write to log file:', logErr);
  }
}

console.log('Testing error logging...');
writeErrorLog('TestContext', new Error('This is a test error'), { testId: 123, status: 'success' });
console.log('Test complete.');
