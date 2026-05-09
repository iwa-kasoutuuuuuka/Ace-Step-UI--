import { db } from './pool.js';
import { randomUUID } from 'crypto';
// UUID generation helper (SQLite doesn't have gen_random_uuid())
export function generateUUID() {
    return randomUUID();
}
// JSON helper for SQLite (serialize objects to strings)
export function toJSON(obj) {
    return JSON.stringify(obj);
}
// JSON helper for SQLite (parse JSON strings)
export function fromJSON(str) {
    if (!str)
        return null;
    try {
        return JSON.parse(str);
    }
    catch {
        return null;
    }
}
// Array helper for SQLite (store arrays as JSON strings)
export function toArray(arr) {
    return JSON.stringify(arr || []);
}
// Array helper for SQLite (parse array from JSON string)
export function fromArray(str) {
    if (!str)
        return [];
    try {
        return JSON.parse(str);
    }
    catch {
        return [];
    }
}
// ISO date string helper
export function toISODate(date) {
    if (!date)
        return null;
    return date.toISOString();
}
// Parse ISO date string
export function fromISODate(str) {
    if (!str)
        return null;
    return new Date(str);
}
// Transaction helper
export function transaction(fn) {
    return db.transaction(fn)();
}
// Batch insert helper
export function batchInsert(table, columns, rows) {
    const placeholders = columns.map(() => '?').join(', ');
    const stmt = db.prepare(`INSERT INTO ${table} (${columns.join(', ')}) VALUES (${placeholders})`);
    const insertMany = db.transaction((items) => {
        for (const row of items) {
            stmt.run(...row);
        }
    });
    insertMany(rows);
}
export { db };
