extends Node

const MOD_DIR = "makizakao-Expresstato/"
const MOD_LOG = "makizakao-Expressrtato"
var path = ""
var extension_path = "extensions/"
var translation_path = "resource/translations/"

func _init(modLoader = ModLoader):
	ModLoaderLog.info("Init", MOD_LOG)
	path = modLoader.UNPACKED_DIR + MOD_DIR
	extension_path = path + extension_path
	translation_path = path + translation_path
	
	
	var extensions = [
		"singletons/run_data.gd",
		"weapons/weapon.gd"
		#"singletons/run_data.gd",
		#"singletons/text.gd",
		#"entities/units/player/player.gd",
		#"main.gd"
	]
	
	var translations = [
		#"bro_express.en.translation",
		#"bro_express.ja.translation",
	]
	
	for extension in extensions:
		modLoader.install_script_extension(extension_path + extension)
	
	for translation in translations:
		modLoader.add_translation_from_resource(translation_path + translation)
	

func _ready():
	_load_content()
	ModLoaderLog.info("Ready", MOD_LOG)
	return


func _load_content():
	ModLoaderLog.info("Loading mod content", MOD_LOG)
	var ContentLoader = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")
	var contents = [
		"content_data/characters.tres",
		"content_data/items.tres",
		"content_data/weapons_melee/galactic_batter_bat.tres"
	]
	
	for content in contents:
		ContentLoader.load_data(path + content, MOD_LOG)
