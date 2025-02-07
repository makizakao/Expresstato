# プレイヤー全員のSPを管理する
extends Node

const _MAX_SP: int = 5
var _wave_ended: bool = false

func _process(delta) -> void:
	# ウェーブが終了したらSPを追加
	if RunData.wave_in_progress == false and _wave_ended == false:
		_wave_ended = true
		# プレイヤーごとに追加
		for player_idx in RunData.players_data.size():
			var is_mod_character = RunData.get_player_effect_bool("expresstato_character_effect", player_idx)
			if not is_mod_character: return
			var current_sp = RunData.get_stat("current_sp", player_idx)
			if current_sp < _MAX_SP:
				RunData.add_stat("current_sp", 1, player_idx)
	elif RunData.wave_in_progress and _wave_ended == true:
		_wave_ended = false
