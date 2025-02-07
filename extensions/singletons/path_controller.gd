extends Node

var _pathes: Dictionary = {
	"path_enigmata": null,
	"path_remembrance": null,
	"path_trailblaze": null,
	"path_propagation": null,
	"path_preservation": load("res://mods-unpacked/makizakao-Expresstato/extensions/singletons/character_path/preservation_path.gd"),
	"path_harmoney": null,
	"path_hunt": null,
	"path_destruction": load("res://mods-unpacked/makizakao-Expresstato/extensions/singletons/character_path/destruction_path.gd").new(),
	"path_equilibrium": null,
	"path_order": null,
	"path_voracity": null,
	"path_elation": null,
	"path_abundance": null,
	"path_nihility": null,
	"path_erudition": null
}

func _process(delta):
	# プレイヤーごとに運命の効果を適用
	for player_idx in RunData.players_data.size():
		# effectは二次配列として出てくるのでforで回す
		for effect in RunData.get_player_effect("path_effect", player_idx):
			_pathes[effect[0]].process(delta, player_idx, effect)

func _ready():
	# プレイヤーごとに運命の効果を適用
	for player_idx in RunData.players_data.size():
		# effectは二次配列として出てくるのでforで回す
		for effect in RunData.get_player_effect("path_effect", player_idx):
			_pathes[effect[0]].init(player_idx, effect)
