class_name TrailblazerBehavior
extends Reference

var _trailblazer_weapons: Dictionary = {
	"weapon_galactic_batter_bat": 0
}

var _current_time: float = 0
var _using_skill: bool = false

func check_using_skill() -> bool:
	return _using_skill

# player.gdの_process()から、
# trailblazer_effectを所持していると呼び出す(フレーム毎処理)
# スキルのクールタイムを制御
func process(delta, effect: Array, weapons) -> void:
	if not _using_skill: return
	_current_time += delta
	if _current_time < effect[1]: return
	_replace_weapons(weapons)
	_using_skill = false
	_current_time = 0
	
# player.gdの_input()から、スキル使用可能状態の時に呼び出す
func use_skill(weapons, player: Player, content_manager) -> void:
	_disable_weapons(weapons)
	var player_weapons = RunData.get_player_weapons(player.player_index)
	_replace_skill_weapons(player_weapons, player, content_manager)
	_using_skill = true

# 武器を無効化
func _disable_weapons(weapons) -> void:
	for weapon in weapons:
		if not (weapon is Weapon): continue
		match weapon.weapon_id:
			"weapon_galactic_batter_bat":
				_trailblazer_weapons[weapon.weapon_id] += 1
				_disable_and_hide_node(weapon)

# スキル武器を通常武器に置き換え
func _replace_weapons(weapons) -> void:
	for weapon in weapons:
		if not (weapon is Weapon): continue
		match weapon.weapon_id:
			"weapon_skill_galactic_batter_bat":
				_disable_and_hide_node(weapon)
			"weapon_galactic_batter_bat":
				_enable_and_show_node(weapon)

# 通常武器をスキル武器に置き換え
func _replace_skill_weapons(player_weapons, player: Player, content_manager) -> void:
	for i in player_weapons.size():
		match player_weapons[i].weapon_id:
			"weapon_galactic_batter_bat":
				var my_id = player_weapons[i].my_id
				var added_weapon = content_manager.skill_weapon_res[my_id]
				player.add_weapon(added_weapon, i)

func _disable_and_hide_node(node: Node) -> void:
	node.set_process(false)
	node.set_physics_process(false)
	node.hide()

func _enable_and_show_node(node: Node) -> void:
	node.set_process(true)
	node.set_physics_process(true)
	node.show()
