extends StaticBody2D

#TODO Ensuring that each object breaks their own and not all at once. Spawn each object uniquely

var maxHP = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TextEdit.text = str(maxHP)
	



func _on_area_2d_body_entered(body: Node2D) -> void:
	#TODO: This coal will break if the collision enters and reenters
	if body.name == "MainPlayer" && maxHP > 0:
		maxHP -= 1
	if body.name == "MainPlayer" && maxHP <= 0:
		queue_free()
