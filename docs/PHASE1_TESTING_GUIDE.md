# Phase 1 動作テストガイド

このドキュメントは、Phase 1「王室の財政」の実装をUEFNエディタでテストするための詳細な手順を説明します。

## 📋 テスト前の準備

### 1. UEFNエディタの起動

1. **Epic Games Launcher**を起動
2. **Unreal Editor for Fortnite**を起動
3. プロジェクト「**ThroneOfLegacy**」を開く

### 2. Verseファイルのコンパイル確認

1. UEFNエディタで**Verse**タブを開く
2. 以下のファイルが正しくコンパイルされているか確認：
   - `Content/Systems/player_data.verse`
   - `Content/Systems/economy_system.verse`
   - `Content/Devices/throne_zone_device.verse`
   - `Content/UI/hud_ui.verse`
   - `Content/Systems/vfx_sound_system.verse`

3. **エラーがある場合**：
   - エラーメッセージを確認
   - 必要に応じてコードを修正
   - 再度コンパイル

## 🏗️ UEFNエディタでの設定手順

### Step 1: Mutator Zoneの配置

1. **ビューポート**でレベルを開く
2. **デバイス**パネルを開く（左側のパネル）
3. **Mutator Zone**を検索
4. **Mutator Zone**をレベルにドラッグ&ドロップ
5. 配置したMutator Zoneを選択
6. **詳細**パネルで以下を設定：
   - **Zone Name**: `ThroneZone`（任意の名前）
   - **Zone Size**: 適切なサイズに設定（例: X=1000, Y=1000, Z=500）
   - **Zone Location**: 玉座の間の位置に配置

### Step 2: Throne Zone Deviceの配置

1. **デバイス**パネルで**Verse Device**を検索
2. **Verse Device**をレベルにドラッグ&ドロップ
3. 配置したデバイスを選択
4. **詳細**パネルで以下を設定：
   - **Verse File**: `throne_zone_device.verse`を選択
   - **Device Class**: `throne_zone_device`が自動的に設定される

5. **Mutator Zone参照の設定**：
   - **詳細**パネルで`throne_zone`プロパティを探す
   - ドロップダウンから先ほど配置した**Mutator Zone**を選択
   - または、Mutator Zoneを選択して**参照を設定**ボタンをクリック

### Step 3: HUD Deviceの配置

1. **Verse Device**を再度配置
2. **詳細**パネルで以下を設定：
   - **Verse File**: `hud_ui.verse`を選択
   - **Device Class**: `hud_device`が自動的に設定される

### Step 4: レベル設定の確認

1. **設定**メニューから**レベル設定**を開く
2. **ゲームモード**が適切に設定されているか確認
3. **プレイヤー数**の設定を確認（テスト用に1人でも可）

## 🎮 テスト実行手順

### Step 1: プレイモードでテスト

1. **プレイ**ボタンをクリック（または`Alt+P`）
2. ゲームが開始される
3. **Mutator Zone内に移動**する
4. 以下を確認：
   - コンソールに「Throne Zone Device: Initialized」が表示される
   - コンソールに「HUD Device: Initialized」が表示される
   - 1秒ごとに「Player gained 1 gold. Total: X」が表示される（Mutator Zone内にいる間）

### Step 2: コンソールログの確認

1. **出力ログ**パネルを開く（下部のパネル）
2. 以下のメッセージが表示されることを確認：
   ```
   Throne Zone Device: Initialized
   HUD Device: Initialized
   Throne Zone: Updating gold for players in zone
   Player gained 1 gold. Total: 1
   Player gained 1 gold. Total: 2
   ...
   ```

### Step 3: HUD表示の確認

1. ゲーム画面で以下が表示されることを確認：
   - **ゴールド表示**: 画面右上に「Gold: X」が表示される
   - **HP表示**: 画面左上に「HP: X / Y」が表示される
   - **レベル表示**: 「Level: X」が表示される
   - **経験値表示**: 「Experience: X / Y」が表示される

   **注意**: 実際のUI表示は、Verse UI APIの実装に依存します。
   現在の実装では`Print`文でコンソールに出力しているため、
   実際のUI表示には追加の実装が必要です。

## 🔧 トラブルシューティング

### 問題1: Verseファイルがコンパイルされない

**原因**: 構文エラーや型エラー

**解決方法**:
1. **Verse**タブでエラーメッセージを確認
2. エラーのある行を確認
3. コードを修正
4. 再度コンパイル

**よくあるエラー**:
- `player`型が見つからない → `/Verse.org/Simulation`のインポートを確認
- `mutator_zone`型が見つからない → `/Fortnite.com/Devices`のインポートを確認
- 関数が見つからない → 関数名のタイプミスを確認

### 問題2: デバイスが動作しない

**原因**: デバイスの参照が正しく設定されていない

**解決方法**:
1. デバイスを選択して**詳細**パネルを確認
2. **Verse File**が正しく設定されているか確認
3. **Mutator Zone**の参照が正しく設定されているか確認
4. デバイスを削除して再配置

### 問題3: ゴールドが生成されない

**原因**: Mutator Zone内にプレイヤーが検出されていない

**解決方法**:
1. Mutator Zoneのサイズと位置を確認
2. プレイヤーがMutator Zone内にいることを確認
3. Mutator Zoneのイベント取得方法を確認
4. コードの`UpdateGoldForPlayersInZone()`関数を確認

**注意**: 現在の実装では、Mutator Zone内のプレイヤーを取得する方法が
疑似コードになっています。実際のUEFN APIに合わせて調整が必要です。

### 問題4: HUDが表示されない

**原因**: Verse UI APIの実装が不完全

**解決方法**:
1. 現在の実装では`Print`文でコンソールに出力しています
2. 実際のUI表示には、Verse UI APIを使用する必要があります
3. UEFNのドキュメントでVerse UI APIの使用方法を確認
4. UI表示の実装を追加

## 📝 テストチェックリスト

### 基本動作確認
- [ ] Verseファイルがコンパイルされる
- [ ] デバイスがレベルに配置できる
- [ ] Mutator Zoneが配置できる
- [ ] デバイスとMutator Zoneの参照が設定できる
- [ ] プレイモードでゲームが開始される

### 機能確認
- [ ] Throne Zone Deviceが初期化される（コンソールログ確認）
- [ ] HUD Deviceが初期化される（コンソールログ確認）
- [ ] Mutator Zone内でゴールドが生成される（コンソールログ確認）
- [ ] ゴールドの値が正しく増加する（コンソールログ確認）
- [ ] Mutator Zone外ではゴールドが生成されない

### UI確認（実装後）
- [ ] ゴールドが画面に表示される
- [ ] HPが画面に表示される
- [ ] レベルが画面に表示される
- [ ] 経験値が画面に表示される

## 🔄 次のステップ

Phase 1のテストが完了したら：

1. **動作確認結果を記録**
   - `docs/DEVELOPMENT_LOG.md`に記録
   - 発見した問題や改善点を記録

2. **コードの調整**
   - UEFNの実際のAPIに合わせてコードを修正
   - Mutator Zoneのイベント取得方法を実装
   - Verse UI APIを使用してHUD表示を実装

3. **Phase 2の準備**
   - 建設システムの実装準備
   - Conditional Buttonの設定方法を確認

## 📚 参考資料

- [UEFN Documentation](https://dev.epicgames.com/documentation/en-us/uefn)
- [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference-in-unreal-editor-for-fortnite)
- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference)
- [Creating Verse Devices](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse)

## ⚠️ 重要な注意事項

1. **Mutator Zoneのイベント取得**:
   - 現在の実装では、Mutator Zone内のプレイヤーを取得する方法が
     疑似コードになっています
   - 実際のUEFN APIを確認して、適切な方法で実装する必要があります

2. **Verse UI API**:
   - 現在のHUD実装は`Print`文でコンソールに出力しています
   - 実際のUI表示には、Verse UI APIを使用する必要があります
   - UEFNのドキュメントでVerse UI APIの使用方法を確認してください

3. **プレイヤーデータの共有**:
   - 現在の実装では、各デバイスが独自の`player_data_map`を持っています
   - 実際の実装では、グローバルなデータ管理方法を検討する必要があります
   - Verseのモジュールシステムを確認して、適切な方法で実装してください
