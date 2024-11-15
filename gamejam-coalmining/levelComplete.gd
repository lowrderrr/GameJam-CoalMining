extends CanvasLayer

@onready var _continue = $continue as Button

func _ready():
	#self.hide()
	_continue.button_down.connect(on_continue_pressed)
	
# where it sends you after button press.
func on_continue_pressed():
	get_tree().change_scene_to_file("res://MainGame/Scenes/Lobby.tscn")

# Link this to some type of check if the players health is below a threshold or something.
func level_complete():
	get_tree().paused = true
	self.show()
