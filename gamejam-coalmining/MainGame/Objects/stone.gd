extends StaticBody2D

#TODO Ensuring that each object breaks their own and not all at once. Spawn each object uniquely

var maxHP = 15
@onready var coal = $"."

var miningaway = false

var localPlayer : Node2D = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TextEdit.text = str(maxHP)
	#Turn off collision if the coal is invisible
	if coal.visible == false:
		$Block.disabled = true
	else:
		$Block.disabled = false
		
	if Input.is_action_just_pressed("Mine"):
		mine()

func mine():
	if miningaway && localPlayer != null:
		if maxHP > 0:
			maxHP -= localPlayer.miningStrength + GlobalVars.addedMining
		if maxHP <= 0:
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	#TODO: This coal will break if the collision enters and reenters
	if coal.visible && body.name == "MainPlayer":
		localPlayer = body
		miningaway = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if coal.visible && body.name == "MainPlayer":
		localPlayer = null
		miningaway = false
