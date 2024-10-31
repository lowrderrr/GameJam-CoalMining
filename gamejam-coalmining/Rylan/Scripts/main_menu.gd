extends Control

@onready var start = $MarginContainer/HBoxContainer/VBoxContainer/Start as Button
@onready var options = $MarginContainer/HBoxContainer/VBoxContainer/Options as Button
@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/Quit as Button
@onready var fade_in_out_animation = $FadeInOutAnimation
@onready var timer = $Timer
@onready var fade_rect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(2.0)
	fade_in_out_animation.play("Fadeinout")
	start.button_down.connect(on_start_pressed)
	options.button_down.connect(on_options_pressed)
	quit.button_down.connect(on_quit_pressed)

func on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Francis/testing_envFT.tscn")
	
func on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Rylan/Scenes/options_menu.tscn")

func on_quit_pressed() -> void:
	get_tree().quit()

func _on_timer_timeout():
	fade_rect.queue_free()
	timer.stop()
