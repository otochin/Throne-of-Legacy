using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Economy System
# 経済システム
#
# このモジュールは、ゴールドの生成と管理を担当します。
# Mutator Zoneでの滞在時間報酬や敵撃破時の報酬を処理します。

# ゴールド生成の定数
GoldPerSecond : int = 1  # 基本レート（1秒ごとに1ゴールド）
GoldUpdateInterval : float = 1.0  # 更新間隔（秒）

# 敵撃破時の報酬定数
BaseEnemyGoldReward : int = 10  # 基本報酬

# ゴールド生成ロジック
# Mutator Zoneでの滞在時間に応じてゴールドを付与
GenerateGoldFromThroneZone(player_data_ref : player_data, current_time : float):void =
    var time_since_last_update : float = current_time - player_data_ref.last_gold_update_time
    if (time_since_last_update >= GoldUpdateInterval) {
        var gold_to_add : int = GoldPerSecond
        player_data_ref.AddGold(gold_to_add)
        set player_data_ref.last_gold_update_time = current_time
        Print("Player gained {gold_to_add} gold. Total: {player_data_ref.GetGold()}")
    } else {}

# 敵撃破時のゴールド報酬
# レベルに応じた報酬を計算（Phase 3以降で実装）
RewardGoldForEnemyKill(player_data_ref : player_data, enemy_level : int):void =
    var reward : int = BaseEnemyGoldReward
    # TODO: Phase 3でレベルに応じた報酬計算を追加
    player_data_ref.AddGold(reward)
    Print("Player gained {reward} gold for killing enemy. Total: {player_data_ref.GetGold()}")
