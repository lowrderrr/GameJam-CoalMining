extends Node2D

#TODO: When the scene loads, randomize all stone, coal, and other minerals on map
@onready var mineral_list = $MineralList
var rng = RandomNumberGenerator.new()
var coalArr = []
var coalVisible = 0
@onready var coal_amount_min: Label = $MainPlayer/Camera2D/Quota/CoalAmount

@onready var label: Label = $MainPlayer/Camera2D/Time/Label
@onready var timer: Timer = $MainPlayer/Camera2D/Time/Timer
var minute = 0
var second = 0

#Note that the "MineralList" is all invisible
func _ready():
	if GlobalVars.minCoal > 10: #Decrease the min coal required to spawn
		GlobalVars.minCoal = 60 - GlobalVars.level * 5
	else:
		GlobalVars.minCoal = 10
	
	if GlobalVars.minCoal <= GlobalVars.quota: #Same quota as the min
		print(str(GlobalVars.minCoal)+" <= "+str(GlobalVars.quota)+" so set to "+str(GlobalVars.minCoal))
		GlobalVars.quota = GlobalVars.minCoal
	elif GlobalVars.minCoal > GlobalVars.quota: #Increase quota
		print(str(GlobalVars.minCoal)+" > "+str(GlobalVars.quota)+" so increment to "+str(GlobalVars.quota + GlobalVars.level * 5))
		print(str(GlobalVars.level)+" times 5 = "+str(GlobalVars.level * 5))
		GlobalVars.quota += 5
		
	coal_amount_min.text = str(GlobalVars.quota)
	if GlobalVars.timerLevel > 60:
		timer.wait_time = 600 - GlobalVars.level * 30
		GlobalVars.timerLevel = timer.wait_time
	else:
		timer.wait_time = 60
		GlobalVars.timerLevel = timer.wait_time
	$MainPlayer/Camera2D/Quota/Level.text = str("Level: ")+str(GlobalVars.level + 1) #Display Level
		
	timer.start()
	#Summon rocks
	var coal_exist_temp = 0
	for child in mineral_list.get_children():
		var random_number = rng.randi_range(0, 10)
		#Make child visible if num in range
		if child.name.begins_with("Coal"):
			coalArr.append(child)
		if random_number <= 4 && random_number >= 0:
			child.visible = true
			if child.name.begins_with("Coal"):
				coalVisible += 1
				coal_exist_temp += 1 #temp
				coalArr.pop_back()
	if coalVisible < GlobalVars.minCoal:
		var req = GlobalVars.minCoal - coalVisible
		for i in range(0, req):
			var summonPls = rng.randi_range(0, len(coalArr) - 1)
			coal_exist_temp += 1 #temp
			coalArr[summonPls].visible = true
			coalArr.pop_at(summonPls)
	print("Coal that exist in the world: "+str(coal_exist_temp)+"/"+str(GlobalVars.minCoal))

func time_left_countdown():
	var time_left = timer.time_left
	minute = floor(time_left / 60)
	second = int(time_left) % 60
	return [minute, second]

func _process(delta):
	#Show the stats levels
	$MainPlayer/Camera2D/Time/CoinAmount.text = str(GlobalVars.coinsTotal)
	$MainPlayer/Camera2D/Time/BootAmount.text = str(GlobalVars.boughtSpeed + 1)
	$MainPlayer/Camera2D/Time/LampAmount.text = str(GlobalVars.boughtLight + 1)
	$MainPlayer/Camera2D/Time/PickaxeAmount.text = str(GlobalVars.boughtMining + 1)
	
	
	
	$MainPlayer/Camera2D/Time/CoalAmount.text = str(GlobalVars.coal_collected)
	label.text = "%02d:%02d" % time_left_countdown()

func _on_timer_timeout() -> void:
	#TODO game over scene if time runs out
	if (minute == 0 && second == 0):
		print("Game Over")
		FadeTransition.transition()
		await FadeTransition.on_transition_finished
		get_tree().change_scene_to_file("res://MainGame/Scenes/gameOver.tscn")
