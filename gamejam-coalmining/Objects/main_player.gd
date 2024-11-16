extends CharacterBody2D


var SPEED = 350.0 + GlobalVars.addedSpeed
var sprintSpeed = SPEED * 1.5
@export var inv: Inv
@export var miningStrength = 1 #Mining power
var thoughtBubble

var item = load("res://Moises/inventory/items/coal.tres")
var shop = false

# 0 is up, 1 is down, 2 is right, 3 is left
var characterDirection = 0
@onready var sprite_2d = $Sprite2D

var showMap = false

func _ready() -> void:
	thoughtBubble = $AnimatedSprite2D

func _physics_process(delta):
	
	if thoughtBubble.frame == 3:
		$CoalItem.visible = true
	elif thoughtBubble.frame == 0:
		$CoalItem.visible = false
		
	$PointLight2D.energy = 0.5 + GlobalVars.addedLight
	if Input.is_action_just_pressed("Map") && showMap == false:
		showMap = true
		$Camera2D/Map.visible = true
	elif Input.is_action_just_pressed("Map") && showMap:
		showMap = false
		$Camera2D/Map.visible = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("Left", "Right")
	var directionY = Input.get_axis("Up", "Down")
	var sprintActivate = Input.is_action_pressed("Sprint")
	
	#Animation
	if (velocity.x > 1):
		sprite_2d.animation = "Right"
		characterDirection = 2
	elif (velocity.x < -1):
		sprite_2d.animation = "Left"
		characterDirection = 3
	elif (velocity.y > 1):
		sprite_2d.animation = "Down"
		characterDirection = 1
	elif (velocity.y < -1):
		sprite_2d.animation = "Up"
		characterDirection = 0
	
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if sprintActivate:
		velocity = velocity.normalized() * sprintSpeed	
	else:
		velocity = velocity.normalized() * SPEED	
	
	if ((directionX || directionY) && !showMap && !shop):
		move_and_slide()
	
	if !directionX && !directionY:
		#print("Idling")
		# 0 is up, 1 is down, 2 is right, 3 is left
		if (characterDirection == 0):
			sprite_2d.animation = "Idle_Up"
		elif (characterDirection == 1):
			sprite_2d.animation = "Idle_Down"
		elif (characterDirection == 2):
			sprite_2d.animation = "Idle_Right"
		elif (characterDirection == 3):
			sprite_2d.animation = "Idle_Left"
	
func _on_lobby_shop(visible) -> void:
	shop = visible


func _on_mines_or_spawn_area_thought_bubble(thinking) -> void:
	if thinking:
		thoughtBubble.play()
	else:
		thoughtBubble.stop()
