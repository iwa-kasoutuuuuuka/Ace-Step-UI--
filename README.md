<p align="center">
  <img src="https://img.shields.io/badge/🎵-ACE--Step_UI-ff69b4?style=for-the-badge&labelColor=1a1a1a" alt="ACE-Step UI" height="60">
</p>

<h1 align="center">ACE-Step UI - 日本語エディション / Japanese Edition</h1>

<p align="center">
  <strong>究極のオープンソース版 Suno オルタナティブ / The Ultimate Open Source Suno Alternative</strong><br>
  <em>オープンソース AI 音楽生成モデル <a href="https://github.com/ace-step/ACE-Step-1.5">ACE-Step 1.5</a> とのシームレスな統合 / Seamless integration with ACE-Step 1.5</em>
</p>

<p align="center">
  <a href="https://www.youtube.com/@Ambsd-yy7os">
    <img src="https://img.shields.io/badge/▶_Subscribe-YouTube-FF0000?style=for-the-badge&logo=youtube" alt="Subscribe on YouTube">
  </a>
  <a href="https://x.com/AmbsdOP">
    <img src="https://img.shields.io/badge/Follow-@AmbsdOP-1DA1F2?style=for-the-badge&logo=x&logoColor=white" alt="Follow on X">
  </a>
</p>

<p align="center">
  <a href="#-demo">Demo</a> •
  <a href="#-why-ace-step-ui">Why ACE-Step</a> •
  <a href="#-features">Features</a> •
  <a href="#-installation">Installation</a> •
  <a href="#-usage">Usage</a> •
  <a href="#-contributing">Contributing</a>
</p>

---

## 🎬 デモ / Demo

<p align="center">
  <a href="https://www.youtube.com/watch?v=8zg0Xi36qGc">
    <img src="https://img.shields.io/badge/▶_Watch_Full_Demo-YouTube-FF0000?style=for-the-badge&logo=youtube" alt="Watch Demo on YouTube">
  </a>
</p>

<p align="center">
  <img src="docs/demo.gif" alt="ACE-Step UI" width="100%">
</p>

<p align="center">
  <em>Spotifyのような洗練されたインターフェースで、プロフェッショナルなAI音楽を100%無料かつローカルで生成。 / Generate professional AI music with a Spotify-like interface - 100% free and local.</em>
</p>

---

## 🚀 なぜ ACE-Step UI なのか？ / Why ACE-Step UI?

**Suno や Udio に月額 $10 以上払うのに疲れていませんか？** ACE-Step 1.5 は、自分のGPUでローカルに動作する**オープンソースのSunoキラー**です。ACE-Step UI は、そのフルパワーを引き出すための**美しくプロフェッショナルなインターフェース**を提供します。

**Tired of paying $10+/month for Suno or Udio?** ACE-Step 1.5 is the **open source Suno killer** that runs locally on your own GPU - and ACE-Step UI gives you a **beautiful, professional interface** to harness its full power.

| 機能 / Feature | Suno/Udio | ACE-Step UI |
|---------------|-----------|-------------|
| **コスト / Cost** | $10-50/month | **永久無料 / FREE forever** |
| **プライバシー / Privacy** | クラウド型 / Cloud-based | **100% ローカル / 100% local** |
| **所有権 / Ownership** | ライセンス制 / Licensed | **すべてあなたのもの / You own everything** |
| **カスタマイズ / Customization** | 制限あり / Limited | **フルコントロール / Full control** |
| **商用利用 / Commercial Use** | 高額プランが必要 / Expensive tiers | **制限なし / No restrictions** |

---

## ✨ 機能 / Features

### 🎵 AI 音楽生成 / AI Music Generation
*   **フル楽曲生成**: 歌詞付きで4分以上のフル楽曲を生成。 / Create complete songs up to 4+ minutes.
*   **インストモード**: ボーカルなしの楽曲生成。 / Generate instrumental tracks.
*   **カスタムモード**: BPM、キー、拍子、長さの微調整。 / Fine-tune BPM, key, and duration.
*   **AI エンハンス**: ジャンルタグを詳細なキャプションに自動変換。 / Enrich genre tags into detailed captions.
*   **J-POP プリセット (New!)**: 日本の音楽シーンに最適化されたプリセット群。 / Specialized J-POP presets.
*   **テーマおまかせ (New!)**: 日本の情景をテーマにした曲名とスタイルを自動提案。 / Random Japanese theme suggestions.

### 🎧 プロフェッショナルなインターフェース / Professional Interface
*   **Spotify風 UI**: ダーク/ライトモード対応のモダンデザイン。 / Spotify-inspired clean design.
*   **ライブラリ管理**: 楽曲の検索、整理、プレイリスト作成。 / Browse, search, and organize tracks.
*   **LANアクセス**: ローカルネットワーク内の他のデバイスからも利用可能。 / Use from any device on your LAN.

### 🛠️ 内蔵ツール / Built-in Tools
*   **オーディオエディタ**: カット、フェード、エフェクト適用 (AudioMass)。 / Trim, fade, and apply effects.
*   **音源分離**: ボーカル、ドラム、ベース等の分離 (Demucs)。 / Separate vocals, drums, bass, and more.
*   **動画生成**: Pexelsの背景動画を使ったMV作成。 / Create music videos with stock backgrounds.

---

## 📋 推奨環境 / Requirements

| 要件 / Requirement | スペック / Specification |
|-------------------|-------------------------|
| **Node.js** | 18 以上 / 18 or higher |
| **Python** | 3.10+ OR Windows ポータブルパッケージ / Portable Package |
| **GPU (NVIDIA)** | 4GB+ VRAM (12GB+ 推奨 / recommended) |
| **CPU動作 / CPU Only** | 可能 (設定変更が必要) / Supported with configuration changes |

---

## ⚡ クイックスタート / Quick Start

### 🪟 Windows - 日本語版ワンクリック起動 (推奨)
```batch
cd ace-step-ui
日本版を起動.bat
```
API + バックエンド + フロントエンドが全て一括で立ち上がります。

### 🪟 Windows - One-Click Start (Standard)
```batch
cd ace-step-ui
start-all.bat
```

---

## 📦 インストール / Installation

### 1. ACE-Step (生成エンジン) のインストール / Install ACE-Step
**Windows ポータブルパッケージ (推奨):**
1. [ACE-Step-1.5.7z](https://files.acemusic.ai/acemusic/win/ACE-Step-1.5.7z) をダウンロード。 / Download the package.
2. 任意のフォルダに展開。 / Extract to a folder.

### 2. ACE-Step UI (本リポジトリ) のインストール / Install ACE-Step UI
```batch
git clone https://github.com/iwa-kasoutuuuuuka/Ace-Step-UI--
cd ace-step-ui
setup.bat
```

---

## 🎮 使い方 / Usage

### Step 1: ACE-Step サーバーの起動 / Start ACE-Step Server
```batch
python_embeded\python -m acestep --port 8001 --enable-api --backend pt --server-name 127.0.0.1
```

### Step 2: ACE-Step UI の起動 / Start ACE-Step UI
```batch
start.bat
```

---

## 💻 CPUのみでの動作について / Running on CPU Only

GPUがない環境でも、バッチファイルを書き換えることでCPU動作が可能です。詳細は `README_JA.md` を参照してください。

It is possible to run on CPU only by adding `--device cpu` to the startup command. See `README_JA.md` for details.

---

## 🤝 貢献 / Contributing

ACE-Step UI をさらに良くするために、あなたの助けが必要です！バグ報告、機能提案、プルリクエストを歓迎します。

We need your help to make ACE-Step UI even better! Bug reports, feature suggestions, and PRs are always welcome.

---

## 📄 ライセンス / License

このプロジェクトは [MIT License](LICENSE) の下でオープンソースとして公開されています。

---

<p align="center">
  <strong>⭐ このプロジェクトが役に立ったら、ぜひスターをお願いします！ ⭐</strong><br>
  <strong>⭐ If this project helps you, please star this repo! ⭐</strong>
</p>

<p align="center">
  <em>Made with ❤️ for the open-source AI music community</em>
</p>
