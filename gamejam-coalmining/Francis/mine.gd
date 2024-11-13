extends Node2D

#TODO: When the scene loads, randomize all stone, coal, and other minerals on map
@onready var mineral_list = $MineralList
var rng = RandomNumberGenerator.new()
var coalArr = []
var coalVisible = 0
var minCoal = 3 #Set the min coal to spawn guarentee

@onready var label: Label = $MainPlayer/Camera2D/Time/Label
@onready var timer: Timer = $MainPlayer/Camera2D/Time/Timer
var minute = 0
var second = 0

#Note that the "MineralList" is all invisible
func _ready():
	timer.start()
	#Summon coal
	for child in mineral_list.get_children():
		var random_number = rng.randi_range(0, 5)
		#Make child visible if num in range
		if child.name.begins_with("Coal"):
			coalArr.append(child)
		if random_number <= 2 && random_number >= 0:
			child.visible = true
			if child.name.begins_with("Coal"):
				coalVisible += 1
				coalArr.pop_back()
			#print("Visible!")
	if coalVisible < minCoal:
		var req = minCoal - coalVisible
		for i in range(0, req):
			var summonPls = rng.randi_range(0, len(coalArr) - 1)
			print("Summonpls: "+str(summonPls))
			print("coalArr: "+str(coalArr))
			coalArr[summonPls].visible = true
			coalArr.pop_at(summonPls)

func time_left_countdown():
	var time_left = timer.time_left
	minute = floor(time_left / 60)
	second = int(time_left) % 60
	return [minute, second]

func _process(delta):
	label.text = "%02d:%02d" % time_left_countdown()

func _on_timer_timeout() -> void:
	#TODO game over scene if time runs out
	if (minute == 0 && second == 0):
		print("Game Over")
