extends Node2D
signal player_near_shop
		
func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainPlayer":
		player_near_shop.emit()
