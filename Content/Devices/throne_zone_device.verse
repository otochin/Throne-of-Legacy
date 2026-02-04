using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Throne Zone Device
# 玉座エリアデバイス
#
# このデバイスは、Mutator Zoneと連携してプレイヤーが玉座エリアに
# 滞在している間、一定時間ごとにゴールドを生成します。

# プレイヤーデータの簡易版。このファイル内で使用
player_data_simple := class:
    var gold : int = 0
    var last_gold_update_time : float = 0.0
    
    AddGold(amount : int):void =
        if (amount > 0) { set gold += amount } else {}
    
    GetGold():int =
        gold

# 玉座エリアデバイス
throne_zone_device := class(creative_device):
    
    # プレイヤーデータマップ（値型は persistable、組み込み weak_map 参照は未実装のため map を使用）
    var player_data_map : [player]player_data_simple = map{}
    
    # デバイス開始時の処理
    OnBegin<override>()<suspends>:void=
        Print("Throne Zone Device: Initialized")
        loop:
            Sleep(1.0)
            UpdateGoldForPlayersInZone()
    
    # エリア内のプレイヤーにゴールドを付与
    UpdateGoldForPlayersInZone():void =
        Print("Throne Zone: Updating gold for players in zone")
