extends "res://mods-unpacked/makizakao-Expresstato/extensions/singletons/character_path/base_path.gd"

var _has_low_hp: bool = false
var _added_damage: Array = []

# 運命のeffectをkeyに指定
func _init():
	key = "path_destruction"

# PathControllerのprocessで、プレイヤーが壊滅の運命を持っていたら、フレーム毎に呼び出す
func process(delta, player_idx: int, effect: Array):
	if _added_damage.empty():
		for player_idx in RunData.players_data.size():
			_added_damage.append(0)
	_handle_gain_damage_pct_hp(effect, player_idx)

# ダメージを残りHPが一定に減少したらダメージを増加させる関数
func _handle_gain_damage_pct_hp(effect: Array, player_idx: int):
	if RunData.wave_in_progress == false:
		_has_low_hp = false
		return
	var cur_hp = RunData.get_player_current_health(player_idx)
	var max_hp = RunData.get_player_max_health(player_idx)
	var damage = max(RunData.get_stat("stat_percent_damage", player_idx), 0)
	if cur_hp < max_hp * (float(effect[2]) / 100.0) and _has_low_hp == false:
		_added_damage[player_idx] = damage * (float(effect[1]) / 100.0)
		_has_low_hp =  true
		# TempStatsによるステータス増加はウェーブ進行時のみ有効、終了後はリセット
		TempStats.add_stat("stat_percent_damage", _added_damage[player_idx], player_idx)
	elif max_hp * (float(effect[2]) / 100.0) < cur_hp and _has_low_hp == true:
		_has_low_hp = false
		TempStats.remove_stat("stat_percent_damage", _added_damage[player_idx], player_idx)
