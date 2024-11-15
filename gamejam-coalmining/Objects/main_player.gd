extends CharacterBody2D


const SPEED = 350.0
const sprintSpeed = SPEED * 1.5
@export var inv: Inv
@export var miningStrength = 1 #Mining power

var item = load("res://Moises/inventory/items/coal.tres")

# 0 is up, 1 is down, 2 is right, 3 is left
var characterDirection = 0
@onready var sprite_2d = $Sprite2D
var xIdle = false
var yIdle = false

func _physics_process(delta):

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
		xIdle = false
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		xIdle = true

	if directionY:
		yIdle = false
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		yIdle = true
		
	if sprintActivate:
		velocity = velocity.normalized() * sprintSpeed	
	else:
		velocity = velocity.normalized() * SPEED	
	
	if xIdle == false || yIdle == false:
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
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	print('collided')
	add_item_to_inventory(item)
	
func add_item_to_inventory(item: InvItem):
	print(inv.item)
	inv.item.append(item)
	print("Added item to inventory:", item.name)
	print(inv.item)
