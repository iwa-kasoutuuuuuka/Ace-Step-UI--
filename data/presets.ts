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
    id: 'rpg-battle',
    name_ja: 'J-RPG 戦闘曲',
    name_en: 'J-RPG Battle',
    style: 'J-RPG Battle, epic orchestral, rock hybrid, fast tempo, heroic, dramatic',
    description_ja: '疾走感のある壮大な戦闘用オーケストラ・ロック。',
    description_en: 'Epic, fast-paced orchestral rock for battle scenes.'
  },
  {
    id: 'anime-op-energy',
    name_ja: 'アニソン OP風 (エネルギッシュ)',
    name_en: 'Anime OP (High Energy)',
    style: 'Anime Opening, J-Rock, high energy, fast tempo, inspirational, punchy drums, power chords',
    description_ja: '疾走感あふれるエネルギッシュなアニメ主題歌。',
    description_en: 'High-energy, fast-paced anime theme song.'
  },
  {
    id: '8bit-retro',
    name_ja: '8-bit レトロゲーム',
    name_en: '8-bit Retro',
    style: '8-bit, chiptune, NES style, electronic, retro gaming, catchy, square wave, game soundtrack',
    description_ja: '懐かしいレトロゲーム風のチップチューンサウンド。',
    description_en: 'Nostalgic, retro 8-bit chiptune sound.'
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
  },
  {
    id: 'visual-novel-piano',
    name_ja: '美少女ゲーム風 (日常/感動)',
    name_en: 'Visual Novel Style',
    style: 'Visual Novel, piano, soft strings, gentle, emotional, peaceful, daily life, sentimental',
    description_ja: '美少女ゲームの日常や感動シーンを彩る優しいピアノ曲。',
    description_en: 'Gentle piano music for daily life or emotional scenes in visual novels.'
  },
  {
    id: 'arcade-techno',
    name_ja: 'アーケード・テクノ',
    name_en: 'Arcade Techno',
    style: 'Arcade game, techno, fast BPM, electronic, rhythmic, cyber, high energy, synthesizer',
    description_ja: 'ゲームセンターの熱気を想起させる高速テクノ。',
    description_en: 'High-speed techno reminiscent of the heat of an arcade.'
  },
  {
    id: 'showa-kayou',
    name_ja: '昭和歌謡',
    name_en: 'Showa Kayou',
    style: 'Showa Kayou, 70s Japanese Pop, nostalgic, orchestral pop, warm brass, emotional melody, vibraphone, clear vocals',
    description_ja: '70-80年代の懐かしく温かい日本の歌謡曲スタイル。',
    description_en: 'Nostalgic and warm Japanese Kayou style from the 70s-80s.'
  },
  {
    id: 'heisei-pop',
    name_ja: '平成ポップス',
    name_en: 'Heisei Pop',
    style: 'Heisei J-Pop, 90s/00s style, bright synthesizers, catchy chorus, optimistic, high energy, upbeat rhythm',
    description_ja: '90-00年代の黄金期を彷彿とさせる、キャッチーで明るいJ-POP。',
    description_en: 'Catchy and bright J-Pop reminiscent of the golden era in the 90s-00s.'
  },
  {
    id: 'reiwa-modern',
    name_ja: '令和最新ヒット風',
    name_en: 'Reiwa Modern Hit',
    style: 'Reiwa style, modern J-Pop, intricate arrangements, digital elements, high BPM, complex melodies, crisp production',
    description_ja: 'SNSや動画サイトで流行している、高速で緻密な最新のJ-POP。',
    description_en: 'High-speed, intricate modern J-Pop popular on SNS and video sites.'
  }
];
