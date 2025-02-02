extends "res://entities/units/player/player.gd"

var behaviors: Dictionary = {
	"trailblazer_effect": TrailblazerBehavior.new()
}

var expresstato_character_skill_effect: Array = [
	"trailblazer_effect",
]

func _process(delta):
	for effect_key in expresstato_character_skill_effect:
		for effect in RunData.get_player_effect(effect_key, player_index):
			if effect.empty(): return
			var weapons = get_node("/root/Main/Entities/Player/Weapons").get_children()
			behaviors[effect_key].process(delta, effect, weapons)

func _input(event):
	# ボタン入力判定
	if not (event is InputEventMouseButton): return
	if (not event.pressed) or  (event.button_index != 2): return
	# SP残量判定
	if RunData.get_stat("current_sp", player_index) < 1: return
	for effect_key in expresstato_character_skill_effect:
		for effect in RunData.get_player_effect(effect_key, player_index):
			var weapons = get_node("/root/Main/Entities/Player/Weapons").get_children()
			if behaviors[effect_key].check_using_skill(): return
			var content_manager = get_node("/root/ModLoader/makizakao-Expresstato/ContentManager")
			behaviors[effect_key].use_skill(weapons, self, content_manager)
	RunData.add_stat("current_sp", -1, player_index)
