class_name Entity
extends CharacterBody2D

signal died(entity)

var dead_: = false
var cleaning_up_: = false

var min_pos_: = Vector2(-9999, -9999)
var max_pos_: = Vector2(9999, 9999)

@onready var sprite_: = $Animation/Sprite2D as Sprite2D
@onready var animation_player_: = $AnimationPlayer as AnimationPlayer
@onready var animation_: = $Animation as Node2D
@onready var collision: = $Collision as CollisionShape2D

func init(zone_min_pos:Vector2, zone_max_pos:Vector2, p_player_ref:Node2D = null, entity_spawner_ref = null) -> void:
	
	min_pos_ = Vector2(
		zone_min_pos.x + sprite_.texture.get_width() / 2.0,
		zone_min_pos.y + sprite_.texture.get_height() / 2.0
	)
	
	max_pos_ = Vector2(
		zone_max_pos.x - sprite_.texture.get_width() / 2.0,
		zone_max_pos.y - sprite_.texture.get_height() / 2.0
	)

func die(knockback_vector:Vector2 = Vector2.ZERO, p_cleaning_up:bool = false) -> void:
	cleaning_up_ = p_cleaning_up
	animation_player_.speed_scale = 1
	dead_ = true
	animation_player_.play("death")
	emit_signal("died", self)
	
func death_animation_finished() -> void :
	queue_free()
	
