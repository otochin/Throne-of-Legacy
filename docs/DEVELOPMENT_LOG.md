# Throne of Legacy - 開発ログ

このファイルは、プロジェクトの開発進捗を記録し、新しいチャットセッションでも開発を正しく続行できるようにするためのログです。

## 開発状況サマリー

**最終更新日**: 2026年2月3日

### 現在のフェーズ
- **Phase 1: 王室の財政** - 実装中

### 完了したタスク
- [x] プロジェクト構造の確認
- [x] Verse開発環境のセットアップ（拡張機能、設定ファイル）
- [x] 企画書・仕様書の作成
- [x] ドキュメントフォルダの整理（`docs/`フォルダに移動）
- [x] `player_data` クラスの実装（`Content/Systems/player_data.verse`）
- [x] `buff_data` クラスの実装（`Content/Systems/player_data.verse`内）
- [x] 経済システムの実装（`Content/Systems/economy_system.verse`）
- [x] Mutator Zoneデバイスの実装（`Content/Devices/throne_zone_device.verse`）
- [x] 基本HUDの実装（`Content/UI/hud_ui.verse`）
- [x] VFX/サウンドシステムの実装（`Content/Systems/vfx_sound_system.verse`）

### 進行中のタスク
- [ ] **コンパイルエラー 3101 の解消**（現時点のブロッカー）
- [ ] Phase 1のテストとデバッグ
- [ ] UEFNエディタでの動作確認

### 次のステップ
1. **最優先**: Script error 3101 を解消する（下記「未解決のコンパイルエラー」参照）
2. コンパイル通過後: UEFNエディタでMutator Zoneを設定
3. デバイスをレベルに配置してテスト
4. ゴールド生成・HUD表示の動作確認
5. Phase 2の実装準備

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
- `Content/Systems/player_data.verse` - プレイヤーデータ管理システム
- `Content/Systems/economy_system.verse` - 経済システム
- `Content/Systems/vfx_sound_system.verse` - VFX/サウンドシステム
- `Content/Devices/throne_zone_device.verse` - 玉座エリアデバイス
- `Content/UI/hud_ui.verse` - 基本HUDシステム

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
- プレイヤーデータは `map(player, player_data)` で管理（`weak_map` は未実装・persistable 制約のため `map` を使用）
- オプション取得は `GetPlayerData` が `(player_data, logic)` を返す形式で表現
- セーブデータは `persistence` モジュールを使用（将来実装）

### モジュール設計
- 各システムは独立したVerseファイルとして実装
- システム間の通信は明確なインターフェースで定義
- 拡張性を考慮した設計

---

## 既知の問題・課題

### 未解決のコンパイルエラー（2026年2月3日時点）

**Script error 3101: Markup content from string is not yet supported.**

| ファイル | 位置 | 内容 |
|----------|------|------|
| `Content/Systems/player_data.verse` | 11行目, 27列目 | 該当行: `buff_data := class:` の直上コメント付近 |
| `Content/Devices/throne_zone_device.verse` | 12行目, 36列目 | 該当行: `player_data_simple := class:` の直上コメント付近 |

**試した対応（いずれもエラー継続）**
- `class<<final>><<persistable>>` のマークアップを削除し、通常の `class:` に変更
- 該当付近のコメントから全角括弧「（）」を削除し、コメントを簡略化

**明日以降の調査候補**
- Verse / UEFN 公式ドキュメントで「3101」「Markup content from string」を検索
- 該当行・列を空にする、コメントを完全に削除するなど、さらに切り詰めた再現テスト
- UEFN / Verse のバージョン差異や既知の不具合の有無を確認

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

#### 午前セッション
- プロジェクトセットアップ完了
- 企画書・仕様書作成
- 開発ログ作成
- ドキュメントを`docs/`フォルダに整理
- GitHubリポジトリへのアップロード完了

#### 午後セッション（Phase 1実装開始）
- **フォルダ構造の作成**
  - `Content/Systems/` フォルダ作成
  - `Content/Devices/` フォルダ作成
  - `Content/UI/` フォルダ作成

- **Phase 1の実装**
  - `player_data` クラスの実装完了
    - 経済データ、RPGデータ、ステータスデータの管理
    - ゴールドの追加/消費関数
    - HP管理関数
    - プレイヤーデータマップの実装
  - `buff_data` クラスの実装完了
  - `economy_system.verse` の実装完了
    - ゴールド生成ロジック
    - 敵撃破時の報酬ロジック
  - `throne_zone_device.verse` の実装完了
    - Mutator Zoneとの連携
    - 定期的なゴールド生成処理
  - `hud_ui.verse` の実装完了
    - ゴールド表示
    - HP表示
    - レベル表示
    - 経験値表示
  - `vfx_sound_system.verse` の実装完了
    - ゴールド獲得時のエフェクト
    - レベルアップ時のエフェクト
    - 購入時のエフェクト

- **実装上の注意点**
  - Verseのモジュールシステムに応じて、各ファイル間の連携方法を検討中
  - UEFNエディタでの実際のAPIを確認して、適切な実装に調整が必要
  - Mutator Zoneのイベント取得方法を確認する必要がある

#### 夕方セッション（コンパイルエラー対応・未完了）

- **解消したエラー**
  - Persistent var の値型は `persistable` である必要がある → `weak_map` を `map` に変更、永続化マークアップは未サポートのため通常の `class` に統一
  - `operator'?'` のオーバーロード不一致 → `GetPlayerData` の戻り値を `player_data?` から `(player_data, logic)` に変更
  - オーバーロード/組み込み関数の参照未実装 → `weak_map` を `map` に変更
  - `var` の型不足 → `var new_data : player_data = player_data{}` で型を明示
  - `decides` 効果がコンテキストで許可されない → `set player_data_map[p] = new_data` を `if (set ...) { ... } else { ... }` で包む
  - コメントの全角括弧を削除し「Markup」誤解釈の可能性を低減

- **未解消（明日以降対応）**
  - **Script error 3101**: 「Markup content from string is not yet supported」
  - 発生箇所: `player_data.verse` 11行27列、`throne_zone_device.verse` 12行36列（いずれも `class` 宣言の直上付近）
  - 上記「既知の問題・課題」に詳細と明日の調査候補を記載済み

- **ドキュメント更新**
  - `docs/QUICK_START.md`: コンパイルエラーとUEFN側オブジェクトの関係を追記（エラーはコード修正で解消、オブジェクト配置はコンパイル通過後）
