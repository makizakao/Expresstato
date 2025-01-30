extends "res://main.gd"

onready var _ui_sp
var wave_ended: bool = false
var _sp_controller = SPController.new()
var _path_controller = PathController.new()


func _ready():
	for player_idx in RunData.players_data.size():
		var path = RunData.get_player_effect("path_effect", player_idx)
		if path.empty(): return
		var scene = preload("res://mods-unpacked/makizakao-Expresstato/extensions/ui/hud/skill_point_ui.tscn")
		var current_sp = RunData.get_stat("current_sp", player_idx)
		_ui_sp = scene.instance()
		$UI.add_child_below_node($UI/HUD, _ui_sp)
		_ui_sp.update_sp(current_sp)

func _process(delta):
	_sp_controller.process(delta)
	_path_controller.process(delta)
