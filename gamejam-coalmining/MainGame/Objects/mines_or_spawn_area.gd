extends StaticBody2D

signal thought_bubble


func _on_to_the_mines_body_entered(body: Node2D) -> void: #To the mines
	if body.name == "MainPlayer":
		FadeTransition.transition()
		await FadeTransition.on_transition_finished
		get_tree().change_scene_to_file("res://MainGame/Scenes/MineScene/mine.tscn")






func _on_to_spawn_body_entered(body: Node2D) -> void: #Back the the grass

	if body.name == "MainPlayer":
		if GlobalVars.coal_collected >= GlobalVars.quota:
			FadeTransition.transition()
			await FadeTransition.on_transition_finished
			get_tree().change_scene_to_file("res://MainGame/Scenes/level_complete.tscn")
		else:
			thought_bubble.emit(true)

func _on_to_spawn_body_exited(body: Node2D) -> void:
	if body.name == "MainPlayer":
		thought_bubble.emit(false)
