// Import style text files
import mainStyleText from './main_style.txt?raw';
import allStyleText from './all_style.txt?raw';

// Main styles (top-level genres) from main_style.txt
export const MAIN_STYLES = mainStyleText
  .split('\n')
  .map(line => line.trim())
  .filter(line => line.length > 0);

// All styles from all_style.txt
export const ALL_STYLES = allStyleText
  .split('\n')
  .map(line => line.trim())
  .filter(line => line.length > 0);

// Japanese-specific styles
export const JAPANESE_STYLES = [
  'J-POP',
  'Anime',
  'City Pop',
  'Eurobeat',
  'Visual Kei',
  'Enka',
  'Vocaloid Style',
  'Future Funk',
  'Kawaii Metal',
  'Shibuya-kei',
  '8-bit (Chiptune)',
  'J-RPG Battle',
  'Anime OP/ED',
  'Denpa-kei',
  'Visual Novel Style'
];

export const JAPANESE_MOOD_TAGS = [
  'エモい', '癒やし', '爆音', 'チルい', '懐かしい', 'アゲアゲ', '疾走感', '切ない', 'お洒落', 'ダーク',
  '熱い', '壮大', '緊迫', '萌え', 'レトロ', 'サイバー'
];

// Backward-compatible alias
export const GENRE_KEYS = MAIN_STYLES;

// Sub-styles: all styles minus the main genres
const mainStylesLower = new Set(MAIN_STYLES.map(s => s.toLowerCase().trim()));

export const SUB_STYLES = ALL_STYLES.filter(style => {
  const styleLower = style.toLowerCase().trim();
  return !mainStylesLower.has(styleLower);
});

// Type definitions
export type MainStyle = typeof MAIN_STYLES[number];
export type AllStyle = typeof ALL_STYLES[number];
export type SubStyle = typeof SUB_STYLES[number];
