export interface Theme {
  name_ja: string;
  name_en: string;
  style_ja: string;
  style_en: string;
  keywords: string;
}

export const JAPANESE_THEMES: Theme[] = [
  {
    name_ja: '桜の舞う季節',
    name_en: 'Cherry Blossom Season',
    style_ja: '春、出会いと別れ、儚さ',
    style_en: 'Spring, meeting and parting, fleeting beauty',
    keywords: 'Spring, Sakura, cherry blossoms, nostalgic, acoustic guitar, soft piano, emotional'
  },
  {
    name_ja: '真夏の夜のドライブ',
    name_en: 'Midnight Summer Drive',
    style_ja: '夏、ネオン、シティ、疾走感',
    style_en: 'Summer, neon lights, city, high speed',
    keywords: 'Summer night, city lights, driving, funk, bass guitar, synthesizer, upbeat'
  },
  {
    name_ja: '雨降る午後のカフェ',
    name_en: 'Rainy Afternoon Cafe',
    style_ja: '雨、静寂、コーヒー、憂鬱',
    style_en: 'Rain, silence, coffee, melancholy',
    keywords: 'Rainy day, cozy, jazz piano, lo-fi, chill, melancholic, acoustic'
  },
  {
    name_ja: '冬の星座',
    name_en: 'Winter Constellations',
    style_ja: '冬、寒空、星、煌めき',
    style_en: 'Winter, cold sky, stars, sparkle',
    keywords: 'Winter, stars, night sky, atmospheric, electronic, shimmering, clear vocals'
  },
  {
    name_ja: '和風フューチャーベース',
    name_en: 'Traditional Future Bass',
    style_ja: '伝統、革新、和楽器、デジタル',
    style_en: 'Tradition, innovation, Japanese instruments, digital',
    keywords: 'Wafuu, Shamisen, Koto, Future Bass, modern Japanese, electronic, energetic'
  }
];
