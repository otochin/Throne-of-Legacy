# ThroneOfLegacy - UEFN Verse Project

このプロジェクトはUnreal Editor for Fortnite (UEFN)用のVerse言語プロジェクトです。

## 開発環境のセットアップ

### 必要な拡張機能

**重要**: UEFNの公式Verse拡張機能は、**UEFNを起動すると自動的にインストールされます**。

1. **Verse拡張機能（公式）**
   - UEFNを起動すると自動的にインストールされます
   - Verseエラーチェック、シンタックスハイライト、コンパイル機能を提供
   - インストール確認方法：Cursor/VSCodeの上部に以下のボタンが表示されていればOK
     - Editor Focus
     - Build Verse Changes
     - Push Verse Change

2. **Unreal Revision Control (URC)**
   - Epic Games公式の拡張機能
   - UEFNと一緒に自動的にインストールされます
   - Verseスクリプトのバージョン管理をサポートします

### 拡張機能が見つからない場合

もし拡張機能がインストールされていない場合：

1. **UEFNを起動する**（これが最も確実な方法です）
   - UEFNを起動すると、自動的に必要な拡張機能がインストールされます

2. **手動で確認する**
   - 拡張機能パネル（Ctrl+Shift+X）を開く
   - 「Verse」で検索
   - または「Unreal」で検索してURC拡張機能を確認

3. **コミュニティ拡張機能（オプション）**
   - 「Syntax Support for Verse」を検索してインストール（オプション）
   - ただし、公式拡張機能があれば通常は不要です

## プロジェクト構造

- `Content/` - Verseスクリプトファイル（.verse）を配置するディレクトリ
- `docs/` - プロジェクトドキュメント
  - `QUICK_START.md` - **新しいチャットセッション開始時のガイド** ⭐
  - `DEVELOPMENT_LOG.md` - 開発ログ・進捗管理
  - `throne_of_legacy_gdd.md` - 企画書・全体設計書
  - `SPECIFICATIONS.md` - 技術仕様書
- `.urc/` - Unreal Revision Controlの設定とデータ
- `ThroneOfLegacy.uefnproject` - UEFNプロジェクト設定ファイル

### 📖 ドキュメントの使い方

**新しいチャットセッションで開発を始める場合**:
1. まず `docs/QUICK_START.md` を参照
2. `docs/DEVELOPMENT_LOG.md` で現在の進捗を確認
3. 必要に応じて他のドキュメントを参照

## Verseファイルの作成

新しいVerseファイルを作成するには：

1. `Content/` ディレクトリ内に `.verse` 拡張子のファイルを作成
2. 必要なモジュールをインポート（例：`using { /Fortnite.com/Devices }`）
3. UEFNエディタでプロジェクトを開いてビルドとテストを実行

## デバッグ

Verseコードのデバッグは、UEFNエディタ内で実行中のゲームに接続して行います。

デバッグ設定は `.vscode/launch.json` に含まれています。

## テストガイド

Phase 1の動作テストを行う場合は、以下のガイドを参照してください：

- **[Phase 1 テストガイド](docs/PHASE1_TESTING_GUIDE.md)** - テスト手順の概要
- **[UEFN セットアップ詳細手順](docs/UEFN_SETUP_STEPS.md)** - 詳細な操作手順

## 参考リンク

- [Epic Games UEFN Documentation](https://dev.epicgames.com/documentation/en-us/uefn)
- [Verse Programming Language](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference-in-unreal-editor-for-fortnite)
