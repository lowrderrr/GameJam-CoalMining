extends StaticBody2D

#TODO Ensuring that each object breaks their own and not all at once. Spawn each object uniquely

var maxHP = 5
@onready var coal = $"."
func _ready():
	#Turn off collision if the coal is invisible
	if coal.visible == false:
		$Block.disabled = true
	else:
		$Block.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TextEdit.text = str(maxHP)
	



func _on_area_2d_body_entered(body: Node2D) -> void:
	#TODO: This coal will break if the collision enters and reenters
	if coal.visible == true:
		if body.name == "MainPlayer" && maxHP > 0:
			maxHP -= 1
		if body.name == "MainPlayer" && maxHP <= 0:
			queue_free()
	else:
		print("Not visible")
