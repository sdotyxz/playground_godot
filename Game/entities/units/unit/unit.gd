class_name Unit
extends Entity

var player_ref_ : Node2D
var current_movement_ : Vector2
var sprites_: = []

var current_movement_behavior_:MovementBehavior

@onready var movement_behavior_: = $MovementBehavior
@export var speed : int

var knockback_direction : Vector2

func _ready()->void :
	current_movement_behavior_ = movement_behavior_

func init(zone_min_pos:Vector2, zone_max_pos:Vector2, p_player_ref:Node2D = null, entity_spawner_ref = null) -> void:
	
	player_ref_ = p_player_ref
	
	movement_behavior_.init(self)
	
	super.init(zone_min_pos, zone_max_pos)

var integrate_forces_velocity_ : Vector2
func _physics_process(delta):
	current_movement_ = get_movement()
	update_animation(current_movement_)
	
	velocity = current_movement_.normalized() * speed
	if dead_ :
		velocity = knockback_direction * speed * 2
	move_and_slide()

func update_animation(movement:Vector2)->void :
	if movement.x > 0:
		sprite_.scale.x = abs(sprite_.scale.x)	
	elif movement.x < 0:
		sprite_.scale.x = -abs(sprite_.scale.x)

func get_movement()->Vector2:
	return current_movement_behavior_.get_movement()

func _on_hurtbox_area_entered(hitBox:Area2D):
	print("_on_hurtbox_area_entered")
	if dead_:
		return	
	var damage = hitBox.damage
	take_damage(damage, hitBox)
	on_hurt()
	hitBox.hit_something(self, damage)
	pass # Replace with function body.

func take_damage(value:int, hitbox:Hitbox) -> void :
	pass
	
func on_hurt()->void :
	pass
