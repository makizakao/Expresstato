extends "res://entities/units/player/player.gd"

var _trailblazer_path = load("res://mods-unpacked/makizakao-Expresstato/extensions/entities/units/player/behavior/trailblazer_behavior.gd")

onready var behaviors: Dictionary = {
	"trailblazer_effect": _trailblazer_path.new()
}

onready var expresstato_character_skill_effect: Array = [
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

func get_damage_value(dmg_value: int, _from_player_index: int, armor_applied: = true, dodgeable: = true, _is_crit: = false, _hitbox: Hitbox = null, _is_burning: = false) -> Unit.GetDamageValueResult:
	var result: = Unit.GetDamageValueResult.new()
	if dodgeable and randf() < min(current_stats.dodge, RunData.get_player_effect("dodge_cap", player_index) / 100.0):
		result.value = 0
		result.dodged = true
	elif _hit_protection > 0:
		result.value = 0
		result.protected = true
		_hit_protection -= 1
	else:
		var armor_coef = RunData.get_armor_coef(current_stats.armor)
		var shield = TempStats.get_stat("current_shield", player_index)
		var val = max(1, round(dmg_value * armor_coef))
		var shield_dmg = val if 0 < shield - val else 0
		TempStats.add_stat("current_shield", shield_dmg, player_index)
		result.value = max(0, val - shield) as int if armor_applied else dmg_value
	return result
