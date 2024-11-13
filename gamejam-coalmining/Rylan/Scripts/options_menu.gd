extends Control

@onready var returnButton = $MarginContainer/VBoxContainer/Return as Button

# Called when the node enters the scene tree for the first time.
func _ready():
	returnButton.button_down.connect(on_return_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_check_box_toggled(toggled_on):
	pass # Replace with function body.


func _on_resolution_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))

func on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Rylan/Scenes/title_screen.tscn")
