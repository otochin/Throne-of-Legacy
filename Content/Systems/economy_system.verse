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
# 戻り値として更新済みの player_data を返す（永続マップ側で再保存する想定）
GenerateGoldFromThroneZone(player_data_ref : player_data, current_time : float):player_data =
    var time_since_last_update : float = current_time - player_data_ref.last_gold_update_time
    if (time_since_last_update >= GoldUpdateInterval) {
        var gold_to_add : int = GoldPerSecond
        var updated_data : player_data = AddGoldToPlayerData(player_data_ref, gold_to_add)
        set updated_data = SetLastGoldUpdateTime(updated_data, current_time)
        Print("Player gained {gold_to_add} gold. Total: {updated_data.gold}")
        updated_data
    } else {
        player_data_ref
    }

# 敵撃破時のゴールド報酬
# レベルに応じた報酬を計算（Phase 3以降で実装）
# 戻り値として更新済みの player_data を返す
RewardGoldForEnemyKill(player_data_ref : player_data, enemy_level : int):player_data =
    var reward : int = BaseEnemyGoldReward
    # TODO: Phase 3でレベルに応じた報酬計算を追加
    var updated_data : player_data = AddGoldToPlayerData(player_data_ref, reward)
    Print("Player gained {reward} gold for killing enemy. Total: {updated_data.gold}")
    updated_data
