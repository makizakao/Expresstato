extends "res://main.gd"

onready var _ui_sp
var enabled = true
var wave_ended: bool = false
var _sp_controller = SPController.new()
var _path_controller = PathController.new()

func _ready():
	var config = get_node("/root/ModLoader/makizakao-Expresstato/Config")
	if not config.expresstato_enabled:
		enabled = false
		return
	for player_idx in RunData.players_data.size():
		_init_ui_sp(player_idx)
		_handle_player_path(player_idx)
		_handle_character_effect_from_weapon(player_idx)

# SPを表示するUIの初期化
func _init_ui_sp(player_idx: int):
	var mod_character = RunData.get_player_effect_bool("expresstato_character_effect", player_idx)
	if not mod_character: return
	var scene = preload("res://mods-unpacked/makizakao-Expresstato/extensions/ui/hud/skill_point_ui.tscn")
	_ui_sp = scene.instance()
	$UI.add_child_below_node($UI/HUD, _ui_sp)

# 運命を追加、削除するメソッド 開拓者用
func _handle_player_path(player_idx: int):
	var require_path_effect = RunData.get_player_effect_bool("add_from_weapon", player_idx)
	if not require_path_effect: return
	var character = RunData.get_player_character(player_idx)
	var content_manager = get_node("/root/ModLoader/makizakao-Expresstato/ContentManager")
	var weapons = RunData.get_player_weapons(player_idx)
	# 運命を追加
	for weapon in weapons:
		var path = content_manager.weapon_pathes.get(weapon.weapon_id, null)
		if path == null: continue
		if _has_effect(path.key, character.effects):
			continue
		character.effects.push_back(path)
		path.apply(player_idx)
	# 運命を削除
	for effect in RunData.get_player_effect("path_effect", player_idx):
		match effect[0]:
			"path_destruction":
				if _has_weapon("weapon_galactic_batter_bat", weapons): continue
				var path = content_manager.weapon_pathes["weapon_galactic_batter_bat"]
				_remove_effect(path.key, character.effects)
				path.unapply(player_idx)

# 武器の必殺話を追加、削除するメソッド 開拓者用
func _handle_character_effect_from_weapon(player_idx: int):
	var require_weapon_effect = RunData.get_player_effect_bool("add_from_weapon", player_idx)
	if not require_weapon_effect: return
	var character = RunData.get_player_character(player_idx)
	var content_manager = get_node("/root/ModLoader/makizakao-Expresstato/ContentManager")
	var weapons = RunData.get_player_weapons(player_idx)
	# 必殺技の追加
	for weapon in weapons:
		var skill = content_manager.skill_weapon_effect.get(weapon.weapon_id, null)
		if skill == null: continue
		if _has_effect(skill.key, character.effects):
			continue
		character.effects.push_back(skill)
		skill.apply(player_idx)
	# 必殺技の削除
	for effect in RunData.get_player_effect("trailblazer_effect", player_idx):
		match effect[0]:
			"weapon_galactic_batter_bat":
				if _has_weapon(effect[0], weapons): continue
				var skill = content_manager.skill_weapon_effect[effect[0]]
				_remove_effect(skill.key, character.effects)
				skill.unapply(player_idx)


func _has_weapon(weapon_id: String, weapons) -> bool:
	for weapon in weapons:
		if weapon.weapon_id == weapon_id:
			return true
	return false

func _has_effect(key: String, effects):
	for effect in effects:
		if effect.key == key:
			return true
	return false

func _remove_effect(key: String, effects):
	for idx in range(effects.size()):
		if effects[idx].key == key:
			effects.remove(idx)
			return

func _process(delta):
	if not enabled: return
	_sp_controller.process(delta)
	_path_controller.process(delta)
	if _ui_sp == null: return
	for player_idx in RunData.players_data.size():
		_handle_ui_sp(player_idx)

func _handle_ui_sp(player_idx: int):
	_ui_sp.update_sp(RunData.get_stat("current_sp", player_idx))
