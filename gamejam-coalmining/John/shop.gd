extends Node2D
signal player_near_shop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _on_area_2d_body_entered(body: Node2D) -> void:
	##TODO: This coal will break if the collision enters and reenters
	#if body.name == "MainPlayer" && maxHP > 0:
		#maxHP -= 1
	#if body.name == "MainPlayer" && maxHP <= 0:
		#queue_free()
		
func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainPlayer":
		player_near_shop.emit()
