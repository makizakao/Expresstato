extends "res://mods-unpacked/makizakao-Expresstato/extensions/singletons/character_path/base_path.gd"

func process(delta, player_idx: int, effect) -> void:
	return

func init(player_idx: int, effect) -> void:
	var cur_hp = RunData.get_player_max_health(player_idx)
	var added_shield = cur_hp / 4
	TempStats.add_stat("current_shield", added_shield, player_idx)
	return
