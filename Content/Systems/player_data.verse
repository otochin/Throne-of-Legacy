using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Player Data Management System
# プレイヤーデータ管理システム
# 
# このモジュールは、プレイヤーごとのゲームデータを管理します。
# 経済データ、RPGデータ、ステータスデータなどを統合的に管理します。

# バフデータ（永続化可能なクラス）
buff_data := class<final><persistable>:
    buff_type : int = 0  # 0: Attack, 1: Speed, 2: HP Regen, 3: Defense, 4: Critical
    buff_value : int = 0  # バフの値（パーセンテージまたは固定値）
    duration : float = 0.0  # 持続時間（秒）、0.0は永続
    start_time : float = 0.0  # 開始時刻

# プレイヤーデータ。すべてのプレイヤー関連データを保持（永続化可能なクラス）
player_data := class<final><persistable>:
    # バージョン管理（スキーマ変更時の互換性確認用）
    Version : int = 1
    
    # 経済データ
    gold : int = 0
    total_gold_earned : int = 0
    
    # RPGデータ
    level : int = 1
    experience : int = 0
    experience_to_next_level : int = 100
    
    # ステータスデータ
    max_hp : int = 100
    current_hp : int = 100
    base_attack : int = 10
    base_defense : int = 5
    base_speed : int = 100
    
    # クラスデータ
    # 0: Knight, 1: Mage, 2: Hunter
    player_class : int = 0
    
    # 建設データ
    unlocked_buildings : []int = array{}
    
    # バフデータ
    active_buffs : []buff_data = array{}
    
    # タイムスタンプ
    last_gold_update_time : float = 0.0

# --- player_data 用ユーティリティ関数 ---

# ゴールドを追加した新しい player_data を返す
AddGoldToPlayerData(data : player_data, amount : int):player_data =
    if (amount > 0) {
        player_data{
            Version := data.Version,
            gold := data.gold + amount,
            total_gold_earned := data.total_gold_earned + amount,
            level := data.level,
            experience := data.experience,
            experience_to_next_level := data.experience_to_next_level,
            max_hp := data.max_hp,
            current_hp := data.current_hp,
            base_attack := data.base_attack,
            base_defense := data.base_defense,
            base_speed := data.base_speed,
            player_class := data.player_class,
            unlocked_buildings := data.unlocked_buildings,
            active_buffs := data.active_buffs,
            last_gold_update_time := data.last_gold_update_time
        }
    } else {
        data
    }

# ダメージを受けた新しい player_data を返す
TakeDamageOnPlayerData(data : player_data, amount : int):player_data =
    player_data{
        Version := data.Version,
        gold := data.gold,
        total_gold_earned := data.total_gold_earned,
        level := data.level,
        experience := data.experience,
        experience_to_next_level := data.experience_to_next_level,
        max_hp := data.max_hp,
        current_hp := Max(data.current_hp - amount, 0),
        base_attack := data.base_attack,
        base_defense := data.base_defense,
        base_speed := data.base_speed,
        player_class := data.player_class,
        unlocked_buildings := data.unlocked_buildings,
        active_buffs := data.active_buffs,
        last_gold_update_time := data.last_gold_update_time
    }

# HPを回復した新しい player_data を返す
HealPlayerData(data : player_data, amount : int):player_data =
    player_data{
        Version := data.Version,
        gold := data.gold,
        total_gold_earned := data.total_gold_earned,
        level := data.level,
        experience := data.experience,
        experience_to_next_level := data.experience_to_next_level,
        max_hp := data.max_hp,
        current_hp := Min(data.current_hp + amount, data.max_hp),
        base_attack := data.base_attack,
        base_defense := data.base_defense,
        base_speed := data.base_speed,
        player_class := data.player_class,
        unlocked_buildings := data.unlocked_buildings,
        active_buffs := data.active_buffs,
        last_gold_update_time := data.last_gold_update_time
    }

# last_gold_update_time を更新した新しい player_data を返す
SetLastGoldUpdateTime(data : player_data, new_time : float):player_data =
    player_data{
        Version := data.Version,
        gold := data.gold,
        total_gold_earned := data.total_gold_earned,
        level := data.level,
        experience := data.experience,
        experience_to_next_level := data.experience_to_next_level,
        max_hp := data.max_hp,
        current_hp := data.current_hp,
        base_attack := data.base_attack,
        base_defense := data.base_defense,
        base_speed := data.base_speed,
        player_class := data.player_class,
        unlocked_buildings := data.unlocked_buildings,
        active_buffs := data.active_buffs,
        last_gold_update_time := new_time
    }

# プレイヤーデータ管理用のグローバルマップ（永続化されたプレイヤーデータ）
var player_data_map : weak_map(player, player_data) = map{}

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

# プレイヤーのデータを取得する関数（存在しない場合は none を返す）
GetPlayerData(p : player):?player_data =
    if (existing := player_data_map[p]) {
        option{existing}
    } else {
        false
    }

# プレイヤーのデータを削除する関数（プレイヤーが離脱した時など）
# 注意: Verseのマップから要素を削除するAPIは未実装のため、キーが存在する場合のみ何もしない（将来実装）
RemovePlayerData(p : player):void =
    if (existing := player_data_map[p]) {
        # TODO: マップから要素を削除する方法が実装されたら remove を追加
    } else {}
