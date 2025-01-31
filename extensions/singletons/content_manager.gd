extends Node

const MOD_LOG = "makizakao-Expresstato"
var _dir = "res://mods-unpacked/makizakao-Expresstato/"
var contents = [
	"content_data/items.tres",
	"content_data/characters.tres",
	"content_data/weapons_melee/galactic_batter_bat.tres",
]
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
