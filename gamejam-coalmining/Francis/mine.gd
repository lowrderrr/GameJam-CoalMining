extends Node2D

#TODO: When the scene loads, randomize all stone, coal, and other minerals on map
@onready var mineral_list = $MineralList
var rng = RandomNumberGenerator.new()

#Note that the "MineralList" is all invisible
func _ready():
	for child in mineral_list.get_children():
		var random_number = rng.randf_range(0, 5)
		#Make child visible if num in range
		if random_number <= 2 && random_number >= 0:
			child.visible = true
			print("Visible!")
