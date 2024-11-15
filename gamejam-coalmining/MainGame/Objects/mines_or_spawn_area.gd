extends StaticBody2D




func _on_to_the_mines_body_entered(body: Node2D) -> void: #To the mines
	if body.name == "MainPlayer":
		FadeTransition.transition()
		await FadeTransition.on_transition_finished
		get_tree().change_scene_to_file("res://MainGame/Scenes/MineScene/mine.tscn")






func _on_to_spawn_body_entered(body: Node2D) -> void: #Back the the grass
	if body.name == "MainPlayer":
		FadeTransition.transition()
		await FadeTransition.on_transition_finished
		get_tree().change_scene_to_file("res://MainGame/Scenes/Lobby.tscn")
