extends Control

@onready var returnButton = $MarginContainer/VBoxContainer/Return as Button
@onready var controls_button = $MarginContainer/VBoxContainer/Controls_Button as Button
@onready var check_box = $MarginContainer/VBoxContainer/CheckBox

# Called when the node enters the scene tree for the first time.
func _ready():
	returnButton.button_down.connect(on_return_pressed)
	controls_button.button_down.connect(on_controls_pressed)


func _on_resolution_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))

func on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://MainGame/Scenes/main_menu.tscn")
	
func on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://MainGame/Scenes/controls.tscn")
