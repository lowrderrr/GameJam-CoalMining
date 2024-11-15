extends Node2D

@onready var intro_animation = $IntroAnimation
@onready var timer_1 = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	intro_animation.play("Fadeinout")
	timer_1.start(6.0)
	#get_tree().change_scene("res://Rylan/Scenes/main_menu.tscn")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://MainGame/Scenes/main_menu.tscn")
