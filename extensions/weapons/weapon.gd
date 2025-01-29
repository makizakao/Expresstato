extends "res://weapons/weapon.gd"

var has_low_hp: bool = false
var added_damage: int = 0

func _process(delta):
	for effect in effects:
		ModLoaderLog.debug(effect.key, "makizakao")
		if effect.key == "gain_damage_pct_hp":
			_handle_gain_damage_pct_hp(effect.get_args(player_index))
	ModLoaderLog.debug("finish", "makizakao")

func _handle_gain_damage_pct_hp(effect):
	var cur_hp = RunData.get_player_current_health(player_index)
	var max_hp = RunData.get_player_max_health(player_index)
	var damage = max(RunData.get_stat("stat_percent_damage", player_index), 0)
	if cur_hp < max_hp * (float(effect[2]) / 100.0) and has_low_hp == false:
		added_damage = damage * (float(effect[0]) / 100.0)
		has_low_hp =  true
		TempStats.add_stat("stat_percent_damage", added_damage, player_index)
	elif max_hp * (float(effect[2]) / 100.0) < cur_hp and has_low_hp == true:
		has_low_hp = false
		TempStats.remove_stat("stat_percent_damage", added_damage, player_index)
