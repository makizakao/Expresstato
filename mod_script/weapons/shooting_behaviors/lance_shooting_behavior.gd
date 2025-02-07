class_name LanceWeaponShootingBehavior
extends MeleeWeaponShootingBehavior

export(NodePath) var lance_wave_container_path: NodePath
export(NodePath) var lance_wave_path: NodePath
export(NodePath) var lance_wave_hitbox_path : NodePath

const LanceAttackType = preload("res://mods-unpacked/makizakao-Expresstato/mod_script/weapons/lance_attack_type.gd")
var _should_fixed_pos: bool = false
var _pre_player_pos: Vector2
var _initial_pos: Vector2

func _ready() -> void:
	_initial_pos = get_node(lance_wave_container_path).rect_global_position

func shoot(distance: float) -> void:
	var initial_position: Vector2 = _parent.sprite.position
	shooting_data = MeleeShootingData.new(_parent.current_stats, _parent.player_index)
	_parent.set_shooting(true)
	match _parent.next_attack_type:
		LanceAttackType.THRUST:
			.melee_thrust_attack(initial_position)
		LanceAttackType.TWO_STAGE:
			two_stage_attack(initial_position, distance)

func two_stage_attack(initial_position: Vector2, distance: float) -> void:
	_parent._hitbox.player_attack_id = _get_next_attack_id()
	
	var recoil = _parent.current_stats.recoil
	var recoil_duration = _parent.current_stats.recoil_duration
	var thrust_half_duration = shooting_data.atk_duration / 2
	var tween_hit_box_scale: Vector2 = Vector2(4, 4)
	var moved_pos = 50
	
	interpolate("position",
		initial_position, Vector2(initial_position.x - recoil, initial_position.y),
		recoil_duration)

	_parent.tween.start()
	yield(_parent.tween, "tween_all_completed")

	SoundManager.play(Utils.get_rand_element(_parent.current_stats.shooting_sounds), _parent.current_stats.sound_db_mod, 0.2)
	_parent.enable_hitbox()
	interpolate("position",
		_parent.sprite.position, Vector2(initial_position.x + moved_pos, initial_position.y),
		thrust_half_duration,
		Tween.TRANS_EXPO, Tween.EASE_IN)

	_parent.tween.start()
	yield(_parent.tween, "tween_all_completed")
	
	yield(get_tree().create_timer(0.2), "timeout")
	var lance_wave: Sprite = get_node(lance_wave_path)
	var lance_wave_hitbox = get_node(lance_wave_hitbox_path)
	lance_wave_hitbox.from = _parent._hitbox.from
	
	lance_wave_hitbox.set_damage(_parent.current_stats.damage / 2)
	lance_wave_hitbox.enable()
	
	interpolate("scale",
		lance_wave.scale, tween_hit_box_scale,
		thrust_half_duration,
		Tween.TRANS_EXPO, Tween.EASE_OUT,
		lance_wave)
	interpolate("modulate:a",
		1.0, 0.0,
		thrust_half_duration,
		Tween.TRANS_EXPO, Tween.EASE_OUT,
		lance_wave)
	_parent.tween.start()
	yield(_parent.tween, "tween_all_completed")
	lance_wave.scale = Vector2(0, 0)
	if not _parent.stats.deal_dmg_on_return:
		_parent.disable_hitbox()
		lance_wave_hitbox.disable()
	
	interpolate("position",
		_parent.sprite.position,
		initial_position,
		shooting_data.back_duration)

	_parent.tween.start()
	yield(_parent.tween, "tween_all_completed")

	if _parent.stats.deal_dmg_on_return:
		_parent.disable_hitbox()
		lance_wave_hitbox.disable()

	_parent.set_shooting(false)
