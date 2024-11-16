extends CanvasLayer

@onready var _continue = $continue as Button

#quota, coal_collected
func _ready():
	#self.hide()
	_continue.button_down.connect(on_continue_pressed)
	
	#Extra coins based on extra coal
	var bonus = ceil(10 * ((float)(GlobalVars.coal_collected - GlobalVars.quota) / GlobalVars.quota))
	GlobalVars.coinsTotal += (10 + bonus) #You win this amount always
	
	$Stats/CoinCoal/Label.text = str(bonus)
	
	
	
	
# where it sends you after button press.
func on_continue_pressed():
	GlobalVars.end_level()
	get_tree().change_scene_to_file("res://MainGame/Scenes/Lobby.tscn")

# Link this to some type of check if the players health is below a threshold or something.
func level_complete():
	get_tree().paused = true
	self.show()
