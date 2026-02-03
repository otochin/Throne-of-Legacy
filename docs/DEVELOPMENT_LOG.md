# Throne of Legacy - 開発ログ

このファイルは、プロジェクトの開発進捗を記録し、新しいチャットセッションでも開発を正しく続行できるようにするためのログです。

## 開発状況サマリー

**最終更新日**: 2026年2月3日

### 現在のフェーズ
- **Phase 1: 王室の財政** - 準備中

### 完了したタスク
- [x] プロジェクト構造の確認
- [x] Verse開発環境のセットアップ（拡張機能、設定ファイル）
- [x] 企画書・仕様書の作成
- [x] ドキュメントフォルダの整理（`docs/`フォルダに移動）

### 進行中のタスク
- [ ] Phase 1の実装開始準備

### 次のステップ
1. `player_data` クラスの実装
2. Mutator Zoneでの滞在時間報酬システムの実装
3. 基本HUDの実装

---

## 詳細ログ

### 2026年2月3日

#### セットアップ完了
- `.vscode/` フォルダの作成
- Verse開発用の設定ファイル作成:
  - `extensions.json` - 推奨拡張機能設定
  - `settings.json` - Verse言語の設定
  - `tasks.json` - ビルドタスク設定
  - `launch.json` - デバッグ設定
- `README.md` - プロジェクト説明書作成
- `docs/throne_of_legacy_gdd.md` - 企画書・仕様書作成
- `docs/SPECIFICATIONS.md` - 技術仕様書作成
- `docs/DEVELOPMENT_LOG.md` - 開発ログ作成（このファイル）

#### 確認事項
- UEFNプロジェクト「ThroneOfLegacy」が存在
- 既存のVerseファイル: `Content/hello_world_device.verse`
- ワークスペース設定: `ThroneOfLegacy.code-workspace`

#### 技術スタック
- **エンジン**: UEFN (Unreal Editor for Fortnite)
- **言語**: Verse
- **プロジェクト名**: ThroneOfLegacy
- **Verse Path**: `/whys@fortnite.com/ThroneOfLegacy`

---

## 実装済みファイル

### Verseファイル
- `Content/hello_world_device.verse` - サンプルデバイス（既存）

### 設定ファイル
- `.vscode/extensions.json`
- `.vscode/settings.json`
- `.vscode/tasks.json`
- `.vscode/launch.json`

### ドキュメント
- `README.md` - プロジェクト概要（ルート）
- `docs/throne_of_legacy_gdd.md` - 企画書・全体設計書
- `docs/SPECIFICATIONS.md` - 技術仕様書
- `docs/DEVELOPMENT_LOG.md` - 開発ログ（このファイル）

---

## 実装予定のファイル構造

```
Content/
├── Systems/
│   ├── player_data.verse          # プレイヤーデータ管理
│   ├── economy_system.verse       # 経済システム
│   ├── building_system.verse      # 建設システム
│   ├── combat_system.verse        # 戦闘システム
│   ├── dungeon_system.verse       # ダンジョンシステム
│   └── persistence_system.verse   # セーブシステム
├── Devices/
│   ├── throne_zone_device.verse   # 玉座エリアデバイス
│   ├── building_button_device.verse # 建設ボタンデバイス
│   └── dungeon_teleporter_device.verse # ダンジョンテレポーターデバイス
├── UI/
│   ├── hud_ui.verse               # 基本HUD
│   ├── building_menu_ui.verse     # 建設メニューUI
│   └── buff_selection_ui.verse    # バフ選択UI
└── hello_world_device.verse       # サンプル（既存）
```

---

## 重要な設計決定

### データ構造
- すべての数値計算は整数（int）で処理（浮動小数点誤差を避けるため）
- プレイヤーデータは `weak_map(player, player_data)` で管理
- セーブデータは `persistence` モジュールを使用

### モジュール設計
- 各システムは独立したVerseファイルとして実装
- システム間の通信は明確なインターフェースで定義
- 拡張性を考慮した設計

---

## 既知の問題・課題

### 現在なし
- 今後、実装中に発見された問題をここに記録

---

## 次のセッションで確認すべきこと

**📌 新しいチャットセッション開始時は、`docs/QUICK_START.md` を参照してください。**

1. **現在のフェーズ**: Phase 1のどのタスクまで完了しているか
2. **実装済みファイル**: どのVerseファイルが実装済みか
3. **テスト状況**: どの機能がテスト済みか
4. **バグ**: 既知のバグや問題があるか

### 推奨参照順序
1. **`docs/DEVELOPMENT_LOG.md`** （このファイル）- 現状把握
2. **`docs/throne_of_legacy_gdd.md`** - 設計思想の確認
3. **`docs/SPECIFICATIONS.md`** - 実装詳細の確認

---

## 開発メモ

### Verse言語の注意点
- Verseは型安全な言語なので、型の明示が重要
- `suspends` キーワードを適切に使用
- エラーハンドリングを忘れずに実装

### UEFNの制約
- デバイスは `creative_device` クラスを継承
- `OnBegin` メソッドで初期化処理を実行
- プレイヤーイベントは適切なデバイスで処理

---

## 変更履歴

### 2026年2月3日
- プロジェクトセットアップ完了
- 企画書・仕様書作成
- 開発ログ作成
- ドキュメントを`docs/`フォルダに整理
