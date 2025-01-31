extends HBoxContainer

var sp = preload("res://mods-unpacked/makizakao-Expresstato/resource/images/ui/hud/expresstato_sp.png")
var sp_empty = preload("res://mods-unpacked/makizakao-Expresstato/resource/images/ui/hud/expresstato_sp_empty.png")

func update_sp(value):
	for i in get_child_count():
		get_child(i).texture = sp if i < value else sp_empty
