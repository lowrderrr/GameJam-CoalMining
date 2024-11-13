extends KinematicBody2D

const SPEED = 200
const JUMP_FORCE = 500  # Adjust this value for the jump height
var velocity = Vector2.ZERO  # Current velocity (x and y)

var sound_player := AudioStreamPlayer.new()
var jump_sound_player := AudioStreamPlayer.new()  # AudioStreamPlayer for jump sound

func _ready():
    # Add sound players to the scene
    add_child(sound_player)
    add_child(jump_sound_player)

    # Load jump sound effect
    jump_sound_player.stream = load("retro-jump-3-236683.mp3")  # Replace with your jump sound file

    # Load boundary sound effect
    sound_player.stream = load("res://bgmusic.wav")

func _physics_process(delta):
    var motion = Vector2.ZERO

    # Horizontal movement (left and right)
    if Input.is_action_pressed("ui_right"):
        motion.x += 1
    if Input.is_action_pressed("ui_left"):
        motion.x -= 1
    if Input.is_action_pressed("ui_down"):
        motion.y += 1
    if Input.is_action_pressed("ui_up"):
        motion.y -= 1

    motion = motion.normalized() * SPEED

    # Jumping logic
    if is_on_floor() and Input.is_action_pressed("ui_accept"):  # Assuming "ui_accept" is the jump key (e.g., spacebar)
        velocity.y = -JUMP_FORCE  # Apply an upward force for the jump
        jump_sound_player.play()  # Play the jump sound effect

    # Gravity
    velocity.y += 1000 * delta  # You can adjust the gravity value as needed

    # Handle movement with physics
    move_and_slide(velocity, Vector2.UP)

    # Play boundary sound when the player is at the edge of the screen
    var c1 = position.x <= 0
    var c2 = position.x >= get_viewport().size.x
    var c3 = position.y <= 0
    var c4 = position.y >= get_viewport().size.y

    if c1 or c2 or c3 or c4:
        sound_player.play()  # Play the boundary sound effect
