# Throne of Legacy - 技術仕様書

このドキュメントは、`throne_of_legacy_gdd.md` の設計思想に基づき、実装レベルの詳細な技術仕様を定義します。

## 1. データ構造仕様

### 1.1 player_data クラス

```verse
player_data := class:
    # 経済データ
    var gold : int = 0
    var total_gold_earned : int = 0
    
    # RPGデータ
    var level : int = 1
    var experience : int = 0
    var experience_to_next_level : int = 100
    
    # ステータスデータ
    var max_hp : int = 100
    var current_hp : int = 100
    var base_attack : int = 10
    var base_defense : int = 5
    var base_speed : int = 100
    
    # クラスデータ
    var player_class : int = 0  # 0: Knight, 1: Mage, 2: Hunter
    
    # 建設データ
    var unlocked_buildings : []int = []
    
    # バフデータ
    var active_buffs : []buff_data = []
    
    # タイムスタンプ
    var last_gold_update_time : float = 0.0
```

### 1.2 buff_data クラス

```verse
buff_data := class:
    var buff_type : int = 0  # 0: Attack, 1: Speed, 2: HP Regen, etc.
    var buff_value : int = 0  # バフの値（パーセンテージまたは固定値）
    var duration : float = 0.0  # 持続時間（秒）、0.0は永続
    var start_time : float = 0.0  # 開始時刻
```

### 1.3 building_data クラス

```verse
building_data := class:
    var building_id : int = 0
    var building_name : string = ""
    var cost : int = 0
    var required_buildings : []int = []  # 依存する建築物のIDリスト
    var prop_reference : prop = ...
    var is_unlocked : bool = false
    var is_built : bool = false
```

## 2. システム実装仕様

### 2.1 経済システム (Economy System)

#### ゴールド生成ロジック

```verse
# Mutator Zoneでの滞在時間報酬
# 1秒ごとにチェックし、ゴールドを付与
GoldPerSecond := 1  # 基本レート
GoldMultiplier := 1.0  # レベルや施設による倍率

# 敵撃破時の報酬
BaseEnemyGoldReward := 10
LevelMultiplier := 1.2  # レベルごとに20%増加
```

#### 実装要件
- ゴールドの増減は必ず整数値で処理
- ゴールドが負の値にならないようにチェック
- ゴールド獲得時にVFXとサウンドを再生

### 2.2 建設システム (Building System)

#### 購入フロー

1. プレイヤーがConditional Buttonを押す
2. システムが所持ゴールドを確認
3. 必要ゴールドを所持している場合:
   - ゴールドを消費
   - 建築物を表示（`Show()`）
   - 依存する次の建築物をアンロック
   - VFX/サウンドを再生
4. 必要ゴールドを所持していない場合:
   - エラーメッセージを表示
   - サウンドを再生（警告音）

#### 建築物の依存関係

```verse
# 建築物ID定義
THRONE_ROOM := 0
SMITHY := 1
MAGIC_LAB := 2
TRAINING_GROUND := 3
WEAPON_UPGRADE := 4

# 依存関係マップ
BuildingDependencies := map{
    SMITHY => [THRONE_ROOM],
    MAGIC_LAB => [THRONE_ROOM],
    TRAINING_GROUND => [THRONE_ROOM],
    WEAPON_UPGRADE => [SMITHY]
}
```

### 2.3 RPG・戦闘システム (Combat System)

#### クラス定義

```verse
# クラスID
KNIGHT := 0
MAGE := 1
HUNTER := 2

# クラスごとの基本ステータス
ClassStats := map{
    KNIGHT => {
        base_hp => 150,
        base_attack => 15,
        base_defense => 10,
        base_speed => 80
    },
    MAGE => {
        base_hp => 80,
        base_attack => 25,
        base_defense => 3,
        base_speed => 100
    },
    HUNTER => {
        base_hp => 100,
        base_attack => 12,
        base_defense => 6,
        base_speed => 120
    }
}
```

#### 経験値システム

```verse
# 経験値計算式
ExperienceReward(amount : int, level_multiplier : float) : int =
    amount * (1.0 + level_multiplier)

# レベルアップに必要な経験値
ExperienceForLevel(level : int) : int =
    100 * level * level  # レベルが上がるほど必要経験値が増加

# HP増加量
HPIncreasePerLevel := 10
```

#### レベルアップ処理

1. 経験値が次のレベルに必要な経験値に達したか確認
2. レベルを増加
3. 最大HPを増加（`HPIncreasePerLevel`分）
4. 現在HPを最大HPまで回復
5. 次のレベルに必要な経験値を計算
6. VFX/サウンドを再生

### 2.4 ローグライク・ダンジョンシステム (Dungeon System)

#### テレポートシステム

```verse
# エリアID
CASTLE_AREA := 0
CURSED_FOREST := 1

# テレポート座標（UEFNエディタで設定）
TeleportLocations := map{
    CASTLE_AREA => vector3{...},
    CURSED_FOREST => vector3{...}
}
```

#### 敵ウェーブシステム

```verse
# ウェーブ定義
WaveData := class:
    var wave_number : int = 0
    var enemy_count : int = 0
    var enemy_types : []int = []
    var spawn_delay : float = 2.0  # 敵の出現間隔（秒）

# ウェーブ進行
# 1. 現在のウェーブの敵をすべて倒す
# 2. 次のウェーブを開始
# 3. 最終ウェーブをクリアすると報酬を付与
```

#### ランダムバフシステム

```verse
# バフタイプ
BUFF_ATTACK := 0
BUFF_SPEED := 1
BUFF_HP_REGEN := 2
BUFF_DEFENSE := 3
BUFF_CRITICAL := 4

# バフ値
BuffValues := map{
    BUFF_ATTACK => 20,  # 攻撃力+20%
    BUFF_SPEED => 15,   # 移動速度+15%
    BUFF_HP_REGEN => 5, # 撃破時HP+5回復
    BUFF_DEFENSE => 10, # 防御力+10%
    BUFF_CRITICAL => 10 # クリティカル率+10%
}

# バフ選択UI
# 1. ダンジョンクリア時に3枚のカードを表示
# 2. プレイヤーが1枚を選択
# 3. 選択したバフを適用
# 4. セッション終了時にバフをリセット
```

## 3. UI仕様

### 3.1 HUD要素

#### 基本HUD（常時表示）
- **ゴールド表示**: 画面右上
  - アイコン + 数値
  - 色: 金色 (#FFD700)
  
- **HP表示**: 画面左上
  - HPバー（赤色）
  - 現在HP / 最大HP のテキスト
  
- **レベル表示**: HPバーの下
  - "Lv. X" のテキスト
  - 経験値バー（青色）

- **クラス表示**: レベル表示の下
  - クラスアイコン + クラス名

### 3.2 メニューUI

#### 建設メニュー
- ボタンを押すと表示
- 建設可能な施設のリスト
- 各施設に:
  - 名前
  - コスト（ゴールド）
  - 説明
  - 購入ボタン

#### バフ選択UI
- ダンジョンクリア時に表示
- 3枚のカードを横並び
- 各カードに:
  - バフ名
  - バフ効果の説明
  - アイコン
- 選択ボタン

## 4. パフォーマンス仕様

### 4.1 更新頻度

- **ゴールド生成チェック**: 1秒ごと
- **HP回復チェック**: 0.5秒ごと（バフ適用時）
- **バフ持続時間チェック**: 1秒ごと
- **UI更新**: 0.1秒ごと（60FPS想定）

### 4.2 メモリ管理

- `weak_map` を使用してプレイヤーデータを管理
- 不要なデータは適切にクリーンアップ
- 配列のサイズを適切に制限

## 5. エラーハンドリング仕様

### 5.1 エラーケース

1. **ゴールド不足**
   - エラーメッセージを表示
   - 警告サウンドを再生

2. **依存施設未建設**
   - エラーメッセージを表示
   - 必要な施設をハイライト

3. **プレイヤーデータ読み込み失敗**
   - デフォルト値で初期化
   - エラーログを出力

4. **テレポート失敗**
   - エラーメッセージを表示
   - 元の位置に戻る

### 5.2 デバッグ機能

- 重要な操作には `Print()` でログ出力
- エラー発生時は詳細な情報を出力
- 開発時のみ有効なデバッグモード

## 6. セーブ・ロード仕様

### 6.1 セーブデータ構造

```verse
save_data := class:
    var player_id : string = ""
    var gold : int = 0
    var level : int = 1
    var experience : int = 0
    var player_class : int = 0
    var unlocked_buildings : []int = []
    var save_timestamp : float = 0.0
```

### 6.2 セーブタイミング

- プレイヤーが島を離れる時
- 重要な進捗が発生した時（レベルアップ、施設建設など）
- 定期的な自動セーブ（5分ごと）

### 6.3 ロード処理

1. プレイヤーが接続
2. プレイヤーIDでセーブデータを検索
3. データが見つかった場合:
   - データを読み込み
   - `player_data` に反映
4. データが見つからない場合:
   - デフォルト値で初期化

## 7. 実装チェックリスト

### Phase 1: 王室の財政
- [ ] `player_data` クラスの実装
- [ ] Mutator Zoneデバイスの実装
- [ ] ゴールド生成ロジックの実装
- [ ] 基本HUDの実装
- [ ] ゴールド獲得VFX/サウンドの実装

### Phase 2: 国土の復興
- [ ] Conditional Buttonデバイスの実装
- [ ] ゴールド消費処理の実装
- [ ] Prop Manipulator制御の実装
- [ ] 依存関係ロジックの実装
- [ ] 建設メニューUIの実装

### Phase 3: 騎士の目覚め
- [ ] クラス選択UIの実装
- [ ] クラスステータス設定の実装
- [ ] 経験値システムの実装
- [ ] レベルアップ処理の実装
- [ ] HP管理システムの実装

### Phase 4: 外界への遠征
- [ ] テレポートシステムの実装
- [ ] 敵生成システムの実装
- [ ] ウェーブ制御システムの実装
- [ ] ランダムバフシステムの実装
- [ ] バフ選択UIの実装

### Phase 5: 永続する王国
- [ ] persistenceモジュールの実装
- [ ] セーブ機能の実装
- [ ] ロード機能の実装
- [ ] メインメニューUIの実装
- [ ] 日本語UI対応
