extends Node

const MOD_LOG = "makizakao-Expresstato"
var _dir = "res://mods-unpacked/makizakao-Expresstato/content_data/"

var contents = [
	"items.tres",
	"characters.tres",
	"sets.tres",
	"weapons_melee/galactic_batter_bat.tres",
	"weapons_melee/supreme_guardian_lance.tres"
]

# 武器による運命効果のリソース 開拓者用
var weapon_pathes: Dictionary = {
	"weapon_galactic_batter_bat": load("res://mods-unpacked/makizakao-Expresstato/content/path/path_destruction_effect.tres")
}

# 武器による必殺技のリソース 開拓者用
var skill_weapon_effect: Dictionary = {
	"weapon_galactic_batter_bat": load("res://mods-unpacked/makizakao-Expresstato/content/characters/trailblazer/trailblazer_effect_2b.tres")
}

# 必殺技発動時の武器のアセット
var skill_weapon_res: Dictionary = {
	"weapon_galactic_batter_bat_1": load("res://mods-unpacked/makizakao-Expresstato/content/weapons/melee/galactic_batter_bat/1/skill_galactic_batter_bat_data.tres"),
	"weapon_galactic_batter_bat_2": load("res://mods-unpacked/makizakao-Expresstato/content/weapons/melee/galactic_batter_bat/2/skill_galactic_batter_bat_2_data.tres"),
	"weapon_galactic_batter_bat_3": load("res://mods-unpacked/makizakao-Expresstato/content/weapons/melee/galactic_batter_bat/3/skill_galactic_batter_bat_3_data.tres"),
	"weapon_galactic_batter_bat_4": load("res://mods-unpacked/makizakao-Expresstato/content/weapons/melee/galactic_batter_bat/4/skill_galactic_batter_bat_4_data.tres")
}

func _ready():
	var config = get_node("/root/ModLoader/makizakao-Expresstato/Config")
	if (not config) or (not config.expresstato_enabled):
		return
	_add_contents()

func _add_contents():
	var ContentLoader = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")
	for content in contents:
		ContentLoader.load_data(_dir + content, MOD_LOG)

func find(id, elements) -> ItemParentData:
	for element in elements:
		if id == element.my_id:
			return element
	return null
