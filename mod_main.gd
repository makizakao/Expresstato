extends Node

const MOD_DIR = "makizakao-Expresstato/"
const MOD_LOG = "makizakao-Expressrtato"
var path = ""
var extension_path = "extensions/"
var translation_path = "resource/translations/"
var content_manager_script = load("res://mods-unpacked/makizakao-Expresstato/extensions/singletons/content_manager.gd")
var config_script = load("res://mods-unpacked/makizakao-Expresstato/extensions/singletons/mod_configs.gd")

func _init(modLoader = ModLoader):
	ModLoaderLog.info("Init", MOD_LOG)
	path = modLoader.UNPACKED_DIR + MOD_DIR
	extension_path = path + extension_path
	translation_path = path + translation_path
	
	# スクリプトのdir
	var extensions = [
		"singletons/player_run_data.gd",
		"singletons/run_data.gd",
		#"weapons/weapon.gd",
		"ui/hud/skill_point_ui.gd",
		"main.gd"
	]
	
	# 翻訳ファイルのdir
	var translations = [
		"expresstato.en.translation",
		"expresstato.ja.translation",
	]
	
	for extension in extensions:
		modLoader.install_script_extension(extension_path + extension)
	
	for translation in translations:
		modLoader.add_translation_from_resource(translation_path + translation)
	

func _ready():
	_load_configs()
	_load_content()
	ModLoaderLog.info("Ready", MOD_LOG)
	return

# ContentLoaderによるアイテムやキャラクターの追加
func _load_content() -> void:
	var content_manager = content_manager_script.new()
	content_manager.set_name("ContentManager")
	$"/root/ModLoader/makizakao-Expresstato".call("add_child", content_manager)

func _load_configs() -> void:
	var config = config_script.new()
	config.set_name("Config")
	$"/root/ModLoader/makizakao-Expresstato".call("add_child", config)
