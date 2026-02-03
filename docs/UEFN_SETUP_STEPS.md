# UEFN Phase 1 セットアップ詳細手順

このドキュメントは、Phase 1のテストに必要なUEFNエディタでの具体的な操作手順を説明します。

## 📋 事前準備チェックリスト

- [ ] UEFNエディタがインストールされている
- [ ] Epic Gamesアカウントにログインしている
- [ ] プロジェクト「ThroneOfLegacy」が開ける
- [ ] Verseファイルがコンパイルできる状態

## 🎯 Step-by-Step セットアップ手順

### Step 1: プロジェクトを開く

1. **Epic Games Launcher**を起動
2. **Unreal Editor for Fortnite**をクリック
3. **プロジェクトを開く**を選択
4. `C:\Users\ariey\uefn\ThroneOfLegacy\ThroneOfLegacy.uefnproject`を選択
5. プロジェクトが開くまで待つ（数分かかる場合があります）

### Step 2: Verseファイルのコンパイル確認

1. エディタ上部の**Verse**タブをクリック
2. 左側のパネルで**Content**フォルダを展開
3. 以下のファイルが表示されることを確認：
   - `Systems/player_data.verse`
   - `Systems/economy_system.verse`
   - `Devices/throne_zone_device.verse`
   - `UI/hud_ui.verse`
   - `Systems/vfx_sound_system.verse`

4. **コンパイルエラーの確認**：
   - 各ファイルをクリックして開く
   - エラーメッセージが表示されていないか確認
   - エラーがある場合は、エラーメッセージを確認して修正

**よくあるエラーと対処法**：
- `player_data`が見つからない → `throne_zone_device.verse`で`player_data`クラスをインポートする必要があります
- `mutator_zone`が見つからない → `/Fortnite.com/Devices`のインポートを確認

### Step 3: レベルにMutator Zoneを配置

1. **ビューポート**（中央の3Dビュー）でレベルを確認
2. 左側の**デバイス**パネルを開く（開いていない場合）
3. **デバイス**パネルの検索バーに「**Mutator Zone**」と入力
4. **Mutator Zone**をビューポートにドラッグ&ドロップ
5. 配置したMutator Zoneを選択（クリック）

### Step 4: Mutator Zoneの設定

1. 右側の**詳細**パネルを確認（開いていない場合は`F4`キー）
2. **Transform**セクションで位置を設定：
   - **Location**: 玉座の間の位置に設定（例: X=0, Y=0, Z=100）
   - **Rotation**: 必要に応じて調整
   - **Scale**: デフォルトのまま

3. **Mutator Zone**セクションで以下を設定：
   - **Zone Name**: `ThroneZone`（任意の名前、後で参照します）
   - **Zone Size**: 
     - **X**: `1000`（幅）
     - **Y**: `1000`（奥行き）
     - **Z**: `500`（高さ）
   - これで1000x1000x500のエリアが作成されます

4. **視覚的な確認**：
   - Mutator Zoneが選択されている状態で、ビューポートに青いボックスが表示されます
   - これがMutator Zoneの範囲です

### Step 5: Throne Zone Deviceを配置

1. **デバイス**パネルで「**Verse Device**」を検索
2. **Verse Device**をビューポートにドラッグ&ドロップ
3. 配置したデバイスを選択

### Step 6: Throne Zone Deviceの設定

1. **詳細**パネルで以下を設定：

   **基本設定**：
   - **Verse File**: ドロップダウンから`throne_zone_device.verse`を選択
   - **Device Class**: `throne_zone_device`が自動的に設定されます

   **Mutator Zone参照の設定**：
   - **詳細**パネルを下にスクロール
   - **Throne Zone**プロパティを探す（`@editable`でマークされたプロパティ）
   - ドロップダウンをクリック
   - 先ほど配置した**Mutator Zone**を選択
   - または、**参照を設定**ボタン（目のアイコン）をクリックしてMutator Zoneを選択

### Step 7: HUD Deviceを配置

1. **Verse Device**を再度配置（Step 5と同じ手順）
2. **詳細**パネルで以下を設定：
   - **Verse File**: `hud_ui.verse`を選択
   - **Device Class**: `hud_device`が自動的に設定されます

### Step 8: レベル設定の確認

1. メニューバーから**編集** → **プロジェクト設定**を開く
2. **ゲームモード**セクションを確認：
   - 適切なゲームモードが設定されているか確認
   - テスト用であればデフォルトのままで問題ありません

3. **マッチメイキング設定**を確認：
   - **最大プレイヤー数**: テスト用に1人でも可
   - **最小プレイヤー数**: 1人

### Step 9: 保存

1. **Ctrl+S**でレベルを保存
2. または、メニューバーから**ファイル** → **保存**を選択

## 🎮 テスト実行手順

### Step 1: プレイモードでテスト

1. エディタ上部の**プレイ**ボタンをクリック（▶️アイコン）
   - または`Alt+P`キーを押す
2. ゲームが開始されます
3. **Mutator Zone内に移動**します：
   - WASDキーで移動
   - スペースキーでジャンプ
   - Mutator Zoneの青いボックス内に入る

### Step 2: コンソールログの確認

1. エディタ下部の**出力ログ**パネルを開く
2. 以下のメッセージが表示されることを確認：

   **初期化メッセージ**：
   ```
   Throne Zone Device: Initialized
   HUD Device: Initialized
   ```

   **ゴールド生成メッセージ**（Mutator Zone内にいる間、1秒ごと）：
   ```
   Throne Zone: Updating gold for players in zone
   Player gained 1 gold. Total: 1
   Player gained 1 gold. Total: 2
   Player gained 1 gold. Total: 3
   ...
   ```

### Step 3: 動作確認

**Mutator Zone内にいる時**：
- [ ] 1秒ごとに「Throne Zone: Updating gold for players in zone」が表示される
- [ ] 1秒ごとに「Player gained 1 gold. Total: X」が表示される
- [ ] ゴールドの値が1ずつ増加する

**Mutator Zone外に移動した時**：
- [ ] ゴールド生成メッセージが表示されなくなる
- [ ] ゴールドの値が増加しない

### Step 4: HUD表示の確認

**現在の実装では**：
- HUDは`Print`文でコンソールに出力されます
- 実際の画面表示には、Verse UI APIを使用する必要があります

**確認方法**：
- 出力ログに「HUD updated for player」が表示されることを確認
- 実際のUI表示は、Phase 1の後半またはPhase 2で実装予定

## 🔧 トラブルシューティング詳細

### 問題1: Verseファイルがコンパイルされない

**エラーメッセージの例**：
```
error: Unknown type 'player_data'
error: Unknown type 'mutator_zone'
```

**解決方法**：

1. **`throne_zone_device.verse`を開く**
2. ファイルの先頭に以下を追加：
   ```verse
   # player_dataクラスをインポートする必要がある場合
   # 注意: Verseでは、同じプロジェクト内の他のファイルのクラスを
   # 直接インポートできない場合があります
   # その場合は、player_dataクラスを同じファイル内で定義するか、
   # 適切な方法で共有する必要があります
   ```

3. **実際の対処法**：
   - `player_data`クラスを`throne_zone_device.verse`内で定義する
   - または、Verseのモジュールシステムを使用して共有する

### 問題2: Mutator Zoneの参照が設定できない

**症状**：
- 詳細パネルに`throne_zone`プロパティが表示されない
- ドロップダウンにMutator Zoneが表示されない

**解決方法**：

1. **Verseファイルを再コンパイル**：
   - Verseタブで`throne_zone_device.verse`を開く
   - 保存して再コンパイル（自動的にコンパイルされます）

2. **デバイスを再配置**：
   - 現在のデバイスを削除
   - 新しいVerse Deviceを配置
   - Verse Fileを再度設定

3. **Mutator Zoneの確認**：
   - Mutator Zoneが正しく配置されているか確認
   - Mutator Zoneの名前が正しく設定されているか確認

### 問題3: ゴールドが生成されない

**症状**：
- Mutator Zone内にいてもゴールドが生成されない
- コンソールに「Throne Zone: Updating gold for players in zone」は表示されるが、
  「Player gained X gold」が表示されない

**原因**：
- Mutator Zone内のプレイヤーを取得する方法が実装されていない
- 現在の実装では疑似コードになっている

**解決方法**：

1. **UEFNのドキュメントを確認**：
   - Mutator Zoneのイベント取得方法を確認
   - `/Fortnite.com/Devices`のAPIドキュメントを確認

2. **コードの修正**：
   - `UpdateGoldForPlayersInZone()`関数を実装
   - Mutator Zone内のプレイヤーを取得する方法を実装

3. **一時的な対処法**：
   - すべてのプレイヤーに対してゴールドを生成する（テスト用）
   - 後でMutator Zoneの判定を追加

### 問題4: デバイスが動作しない

**症状**：
- プレイモードでデバイスが初期化されない
- コンソールにメッセージが表示されない

**解決方法**：

1. **デバイスの確認**：
   - デバイスが正しく配置されているか確認
   - Verse Fileが正しく設定されているか確認

2. **コンパイルエラーの確認**：
   - Verseタブでエラーがないか確認
   - エラーがある場合は修正

3. **デバイスの再配置**：
   - デバイスを削除して再配置
   - Verse Fileを再度設定

## 📝 テストチェックリスト（詳細版）

### セットアップ確認
- [ ] プロジェクトが開ける
- [ ] Verseファイルがコンパイルされる
- [ ] Mutator Zoneが配置できる
- [ ] Mutator Zoneのサイズと位置が設定できる
- [ ] Verse Deviceが配置できる
- [ ] Verse Fileが設定できる
- [ ] Mutator Zoneの参照が設定できる

### 動作確認
- [ ] プレイモードでゲームが開始される
- [ ] Throne Zone Deviceが初期化される（コンソールログ確認）
- [ ] HUD Deviceが初期化される（コンソールログ確認）
- [ ] Mutator Zone内でゴールドが生成される（コンソールログ確認）
- [ ] ゴールドの値が正しく増加する（コンソールログ確認）
- [ ] Mutator Zone外ではゴールドが生成されない

### 次のステップ
- [ ] テスト結果を`docs/DEVELOPMENT_LOG.md`に記録
- [ ] 発見した問題を記録
- [ ] コードの改善点を記録
- [ ] Phase 2の実装準備

## 📚 参考資料

- [UEFN Documentation](https://dev.epicgames.com/documentation/en-us/uefn)
- [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference-in-unreal-editor-for-fortnite)
- [Creating Verse Devices](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse)
- [Mutator Zone Documentation](https://dev.epicgames.com/documentation/en-us/uefn/mutator-zone-in-unreal-editor-for-fortnite)
