export interface Preset {
  id: string;
  name_ja: string;
  name_en: string;
  style: string;
  description_ja: string;
  description_en: string;
}

export const JPOP_PRESETS: Preset[] = [
  {
    id: 'city-pop',
    name_ja: 'シティ・ポップ',
    name_en: 'City Pop',
    style: 'City Pop, 80s Japanese Pop, nostalgic, upbeat, funky bass, synthesizers, urban vibe, clear female vocals',
    description_ja: '80年代の都会的で洗練されたサウンド。',
    description_en: 'Sophisticated urban sound from the 80s.'
  },
  {
    id: 'anime-opening',
    name_ja: 'アニソン (OP風)',
    name_en: 'Anime OP',
    style: 'Anime Opening, J-Rock, high energy, fast tempo, powerful vocals, melodic, orchestral elements',
    description_ja: '疾走感のある力強いアニメ主題歌スタイル。',
    description_en: 'Powerful, high-energy anime theme song style.'
  },
  {
    id: 'emotional-ballad',
    name_ja: '切ないバラード',
    name_en: 'Emotional Ballad',
    style: 'J-Pop Ballad, emotional, piano, strings, heartfelt vocals, slow tempo, melancholic yet hopeful',
    description_ja: 'ピアノとストリングスが美しい泣けるバラード。',
    description_en: 'Beautiful ballad with piano and strings.'
  },
  {
    id: 'vocaloid-style',
    name_ja: 'ボカロ風',
    name_en: 'Vocaloid Style',
    style: 'Vocaloid style, electronic, high-pitched vocals, fast BPM, complex melody, digital pop',
    description_ja: 'ボカロ曲特有の高速で緻密な電子ポップ。',
    description_en: 'High-speed, intricate electronic pop unique to Vocaloid.'
  },
  {
    id: 'j-rock',
    name_ja: 'J-ロック',
    name_en: 'J-Rock',
    style: 'J-Rock, alternative rock, distorted guitars, energetic drums, passionate vocals, catchy hooks',
    description_ja: '日本のロックシーンを彷彿とさせる熱いサウンド。',
    description_en: 'Passionate sound reminiscent of the Japanese rock scene.'
  },
  {
    id: 'idol-pop',
    name_ja: 'アイドルポップ',
    name_en: 'Idol Pop',
    style: 'Japanese Idol Pop, cute, energetic, group vocals, sparkles, upbeat, catchy, happy',
    description_ja: '明るく元気な王道アイドルソング。',
    description_en: 'Bright and energetic classic idol pop song.'
  }
];
