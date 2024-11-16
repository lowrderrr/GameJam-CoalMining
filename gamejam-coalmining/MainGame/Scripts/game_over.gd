extends CanvasLayer

@onready var to_title = $To_Title

func _ready():
	#self.hide()
	to_title.button_down.connect(on_exit_pressed)
	
# Called when the node enters the scene tree for the first time.
func on_exit_pressed():
	GlobalVars.reset()
	get_tree().change_scene_to_file("res://MainGame/Scenes/main_menu.tscn")

# Link this to some type of check if the players health is below a threshold or something.
func game_over():
	get_tree().paused = true
	self.show()
