extends Control

@onready var back_to_options = $back_to_options as Button

func _ready():
	back_to_options.button_down.connect(on_back_to_options_pressed)
	
func on_back_to_options_pressed() -> void:
	get_tree().change_scene_to_file("res://MainGame/Scenes/options_menu.tscn")
