# ACE-Step UI 日本語版 開発スキルガイド (skill.md)

このドキュメントは、ACE-Step UI の日本語版を開発・維持するためのガイドラインです。

## 1. プロジェクト概要
ACE-Step UI は、オープンソースの AI 音楽生成モデル [ACE-Step 1.5](https://github.com/ace-step/ACE-Step-1.5) のためのフロントエンドインターフェースです。Spotify 風のモダンなデザインで、ローカルでの音楽生成を快適にします。

## 2. 日本語化の基本方針
- **UI 表示の完全日本語化**: `i18n/translations.ts` を使用して、すべての UI テキストを自然な日本語にします。
- **モデル用タグの扱い**: AI モデル (ACE-Step) は英語のタグを最適に解釈するため、内部的な生成プロンプトには英語を使用し、UI 上での選択肢や説明には日本語を併記または提供します。
- **デフォルト設定の最適化**: 日本のユーザーが起動してすぐに使いやすいよう、言語設定のデフォルトを `ja` にします。

## 3. 主要な開発タスク

### A. 言語設定の日本語デフォルト化
`context/I18nContext.tsx` 内の初期状態を変更します。
```typescript
const [language, setLanguage] = useState<Language>(() => {
  const stored = localStorage.getItem('language') as Language;
  // デフォルトを 'ja' に変更
  return stored === 'zh' || stored === 'en' || stored === 'ja' || stored === 'ko' ? stored : 'ja';
});
```

### B. 翻訳のブラッシュアップ
`i18n/translations.ts` の `ja` セクションを定期的に見直し、最新の機能に対応させます。特に AI Music 特有の用語（CoT, LoRA, CFG Scale など）の訳語を統一します。

### C. 日本向けスタイルの追加 (予定)
`data/main_style.txt` や `data/all_style.txt` に日本の音楽ジャンル（J-POP, City Pop, Enka, Visual Kei など）を追加検討します。
※ モデルの対応状況を確認しながら進める必要があります。

### D. ドキュメントの日本語化
- `README_JA.md` の作成
- インストール手順の日本語解説

## 4. 実行環境のセットアップ
1. **Node.js**: v18以上が必要。
2. **依存関係のインストール**:
   ```bash
   npm install
   cd server && npm install && cd ..
   ```
3. **開発サーバーの起動**:
   ```bash
   npm run dev
   ```

## 5. 注意事項
- **API 通信**: バックエンド (`server/`) と ACE-Step API (`localhost:8001`) が正常に動作している必要があります。
- **ローカルストレージ**: 言語設定はブラウザの `localStorage` に保存されるため、開発中に変更が反映されない場合はクリアするかシークレットモードで確認してください。
