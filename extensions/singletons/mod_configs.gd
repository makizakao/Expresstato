extends Node

var expresstato_enabled = true
const _ENABLED_OPTION_NAME = "mod_enabled"

var change_trailblazer_to_female = false
const _CHANGE_TRAILBLAZER_TO_FEMALE_OPTION_NAME = "change_trailblazer_to_female"

const _MOD_NAME = "makizakao-Expressrtato"
const _CONFIG_FILENAME = "user://configs/makizakao-Expresstato/default.cfg"
const _CONFIG_SECTION = "options"

func _ready():
	_load_configs()

func _load_configs() -> void:
	var config = ConfigFile.new()
	if config.load(_CONFIG_FILENAME) != OK:
		_save_configs()
	expresstato_enabled = config.get_value(_CONFIG_SECTION, _ENABLED_OPTION_NAME, true)
	change_trailblazer_to_female = config.get_value(_CONFIG_SECTION, _CHANGE_TRAILBLAZER_TO_FEMALE_OPTION_NAME, false)

func _save_configs() -> void:
	var config = ConfigFile.new()
	config.set_value(_CONFIG_SECTION, _ENABLED_OPTION_NAME, expresstato_enabled)
	config.set_value(_CONFIG_SECTION, _CHANGE_TRAILBLAZER_TO_FEMALE_OPTION_NAME, change_trailblazer_to_female)
	
	config.save(_CONFIG_FILENAME)
