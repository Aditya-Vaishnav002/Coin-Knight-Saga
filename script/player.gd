extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get movement direction
	var direction = Input.get_axis("move_left", "move_right")

	# Horizontal movement
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Animation controller
	if not is_on_floor():
		animated_sprite.play("jump")

	elif direction == 0:
		animated_sprite.play("idle")

	else:
		animated_sprite.play("run")

	move_and_slide()
