class_name Unit
extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var body_sprite : Sprite2D = $Animation/Body
@onready var animation : Node2D = $Animation
@onready var finite_state_machine : FiniteStateMachine = $FiniteStateMachine

@export var speed = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 0 #ProjectSettings.get_setting("physics/2d/default_gravity")

var target_position = Vector2.ZERO

func _ready():
	target_position = position
	finite_state_machine.start()
	pass

func _physics_process(delta):
	# move the unit to the target position
	if !is_target_reached():
		var direction = target_position - position
		direction = direction.normalized()
		velocity = direction * speed
		if direction.x < 0:
			animation.scale = Vector2(-1, 1)
		elif direction.x > 0:
			animation.scale = Vector2(1, 1)
		move_and_slide()
	# if Input.is_action_just_pressed("unit_attack"):
	# 	animation_player.play("attack")

	# # Add the gravity.
	# if not is_on_floor():
	# 	velocity.y += gravity * delta

	# # Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	# 	velocity.y = JUMP_VELOCITY

	# # Get the input direction and handle the movement/deceleration.
	# # As good practice, you should replace UI actions with custom gameplay actions.
	# var direction_x = Input.get_axis("ui_left", "ui_right")
	# var direction_y = Input.get_axis("ui_up", "ui_down")
	# if direction_x != 0 || direction_y != 0:
	# 	animation_player.play("move")

	# if direction_x != 0:
	# 	velocity.x = direction_x * speed
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, speed)
	
	# if direction_y != 0:
	# 	velocity.y = direction_y * speed
	# else:
	# 	velocity.y = move_toward(velocity.y, 0, speed)

	# if direction_x < 0:
	# 	animation.scale = Vector2(-1, 1)
	# elif direction_x > 0:
	# 	animation.scale = Vector2(1, 1)

	# move_and_slide()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "move" || anim_name == "attack":
		animation_player.play("idle")

func set_target_position(in_position : Vector2):
	target_position = in_position

# check if the target position is reached and return
func is_target_reached() -> bool:
	return position.distance_to(target_position) < 10

