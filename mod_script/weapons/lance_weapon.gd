class_name LanceWeapon
extends MeleeWeapon

const LanceAttackType = preload("res://mods-unpacked/makizakao-Expresstato/mod_script/weapons/lance_attack_type.gd")


var _attack_count: int = 0
var _attack_change_value: int = 2

func shoot() -> void:
	.shoot()
	_attack_count += 1
	if _attack_count < _attack_change_value: return
	if next_attack_type == LanceAttackType.THRUST:
		next_attack_type = LanceAttackType.TWO_STAGE
		return
	next_attack_type = LanceAttackType.THRUST
	_attack_count = 0
	return
