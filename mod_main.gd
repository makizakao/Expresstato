extends Node

const MOD_DIR = "makizakao-BroExpress/"
const MOD_LOG = "makizakao-BroExpress"
var path = ""
var extension_path = "extensions/"
var translation_path = "resource/translations/"

func _init(modLoader = ModLoader):
	ModLoaderUtils.log_info("Init", MOD_LOG)
	path = modLoader.UNPACKED_DIR + MOD_DIR
	extension_path = path + extension_path
	translation_path = path + translation_path
	
	
	var extensions = [
		#"singletons/player_run_data.gd",
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
	ModLoaderUtils.log_info("Ready", MOD_LOG)
	return


func _load_content():
	ModLoaderUtils.log_info("Loading mod content", MOD_LOG)
	var ContentLoader = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")
	
	ContentLoader.load_data(path + "content_data/characters.tres", MOD_LOG)
	ContentLoader.load_data(path + "content_data/items.tres", MOD_LOG)
