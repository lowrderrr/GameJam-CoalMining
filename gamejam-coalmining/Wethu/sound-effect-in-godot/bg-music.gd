extends KinematicBody2D

const SPEED = 200
var bg_music := AudioStreamPlayer.new()

func _ready():
	bg_music.stream = load("res://bgmusic.wav")
	bg_music.autoplay = true
	add_child(bg_music)


func _physics_process(delta):
	var motion = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
		
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
	if Input.is_action_pressed("ui_down"):
		motion.y += 1
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1

	motion = motion.normalized() * SPEED
	move_and_slide(motion) 
