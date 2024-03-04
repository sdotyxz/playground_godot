class_name Soldier
extends Unit

@onready var wander_timer : Timer = $Timers/WanderTimer

@export var wander_radius : float = 100

# define vector2 zero as anchor point
var anchor_position = Vector2.ZERO

var chase_target : Enemy = null
var attack_target : Enemy = null

# override ready function, get the position and set it to anchor point
func _ready():
	# call the super class ready function
	super._ready()
	# set the anchor point to the position
	anchor_position = position

# override physics process
func _physics_process(delta):
	# call the super class physics process
	super._physics_process(delta)

# pick a random point within the wander radius
func pick_wander_position():
	# get a random point within the wander radius
	var random_position = Vector2(randf_range(-wander_radius, wander_radius), randf_range(-wander_radius, wander_radius))
	return anchor_position + random_position

func start_wander():
	if wander_timer.is_stopped():
		# start the wander timer
		wander_timer.start()

func _on_wander_timer_timeout():
	# set the wander position
	var wander_position = pick_wander_position()
	set_target_position(wander_position)
	pass # Replace with function body.

func _on_look_area_body_exited(body:Node2D):
	# check body is Enemy or not
	if body is Enemy:
		# log the enemy is out of sight
		print("Enemy out of sight")
		set_chase_target(null)

func _on_look_area_body_entered(body:Node2D):
	# check body is Enemy or not
	if body is Enemy:
		# log the enemy is in sight
		print("Enemy in sight")
		set_chase_target(body)

# set chase target
func set_chase_target(target:Node2D):
	chase_target = target

# has chase target return true
func has_chase_target():
	return chase_target != null

func _on_attack_area_body_exited(body:Node2D):
	# check body is Enemy or not
	if body is Enemy:
		# log the enemy is out of attack range
		print("Enemy out of attack range")
		set_attack_target(null)

func _on_attack_area_body_entered(body:Node2D):
	# check body is Enemy or not
	if body is Enemy:
		# log the enemy is in attack range
		print("Enemy in attack range")
		set_attack_target(body)

# set attack target
func set_attack_target(target:Node2D):
	attack_target = target

# has attack target return true
func has_attack_target():
	return attack_target != null