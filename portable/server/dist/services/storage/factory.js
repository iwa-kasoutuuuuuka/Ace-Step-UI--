import { LocalStorageProvider } from './local.js';
let storageInstance = null;
export function getStorageProvider() {
    if (storageInstance) {
        return storageInstance;
    }
    // Always use local storage for ACE-Step UI
    console.log('Initializing local storage provider');
    storageInstance = new LocalStorageProvider();
    return storageInstance;
}
export function resetStorageProvider() {
    storageInstance = null;
}
