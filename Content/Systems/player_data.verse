using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Player Data Management System
# プレイヤーデータ管理システム
# 
# このモジュールは、プレイヤーごとのゲームデータを管理します。
# 経済データ、RPGデータ、ステータスデータなどを統合的に管理します。

# バフデータ
buff_data := class:
    var buff_type : int = 0  # 0: Attack, 1: Speed, 2: HP Regen, 3: Defense, 4: Critical
    var buff_value : int = 0  # バフの値（パーセンテージまたは固定値）
    var duration : float = 0.0  # 持続時間（秒）、0.0は永続
    var start_time : float = 0.0  # 開始時刻

# プレイヤーデータ。すべてのプレイヤー関連データを保持
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
    # 0: Knight, 1: Mage, 2: Hunter
    var player_class : int = 0
    
    # 建設データ
    var unlocked_buildings : []int = array{}
    
    # バフデータ
    var active_buffs : []buff_data = array{}
    
    # タイムスタンプ
    var last_gold_update_time : float = 0.0
    
    # ゴールドを追加する関数
    AddGold(amount : int):void =
        if (amount > 0) {
            set gold += amount
            set total_gold_earned += amount
        } else {}
    
    # ゴールドを消費する関数
    SpendGold(amount : int):logic =
        if (gold >= amount and amount > 0) {
            set gold -= amount
            true
        } else false
    
    # ゴールドを取得する関数
    GetGold():int =
        gold
    
    # HPを回復する関数
    HealHP(amount : int):void =
        set current_hp = Min(current_hp + amount, max_hp)
    
    # ダメージを受ける関数
    TakeDamage(amount : int):void =
        set current_hp = Max(current_hp - amount, 0)
    
    # 現在HPを取得する関数
    GetCurrentHP():int =
        current_hp
    
    # 最大HPを取得する関数
    GetMaxHP():int =
        max_hp
    
    # レベルを取得する関数
    GetLevel():int =
        level
    
    # 経験値を追加する関数
    AddExperience(amount : int):void =
        if (amount > 0) {
            set experience += amount
            # レベルアップチェックは別の関数で処理
        } else {}
    
    # 経験値を取得する関数
    GetExperience():int =
        experience
    
    # 次のレベルに必要な経験値を取得する関数
    GetExperienceToNextLevel():int =
        experience_to_next_level

# プレイヤーデータ管理用のグローバルマップ（値型は persistable である必要あり）
var player_data_map : map(player, player_data) = map{}

# プレイヤーのデータを取得する関数（存在しない場合は新規作成）
GetOrCreatePlayerData(p : player):player_data =
    if (existing := player_data_map[p]) {
        existing
    } else {
        var new_data : player_data = player_data{}
        if (set player_data_map[p] = new_data) {
            new_data
        } else {
            new_data
        }
    }

# プレイヤーのデータを取得する関数（存在しない場合は (ダミー, false) を返す）
GetPlayerData(p : player):(player_data, logic) =
    if (existing := player_data_map[p]) {
        (existing, true)
    } else {
        (player_data{}, false)
    }

# プレイヤーのデータを削除する関数（プレイヤーが離脱した時など）
# 注意: Verseのマップから要素を削除するAPIは未実装のため、キーが存在する場合のみ何もしない（将来実装）
RemovePlayerData(p : player):void =
    if (existing := player_data_map[p]) {
        # TODO: マップから要素を削除する方法が実装されたら remove を追加
    } else {}
