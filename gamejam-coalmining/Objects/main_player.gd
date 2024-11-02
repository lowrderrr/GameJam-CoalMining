extends CharacterBody2D


const SPEED = 500.0
const sprintSpeed = SPEED * 2

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("Left", "Right")
	var directionY = Input.get_axis("Up", "Down")
	var sprintActivate = Input.is_action_pressed("Sprint")
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
	move_and_slide()