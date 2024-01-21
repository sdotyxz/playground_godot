class_name StayInRangeFromPlayerMovementBehavior
extends MovementBehavior

@export var target_range : int = 300
@export var target_range_randomization : int = 100

var _actual_target_range:float

var player_ref:Node2D = null

func _ready()->void :
	_actual_target_range = target_range + randf_range( - target_range_randomization, target_range_randomization)

func init(parent:Node)->Node:
	var _init = super.init(parent)
	player_ref = (parent_ as Unit).player_ref_
	return self

func get_movement()->Vector2:
	var target_position = get_target_position()
	if Utils.vectors_approx_equal(target_position, parent_.global_position, EQUALITY_PRECISION):
		return Vector2.ZERO
	else :
		return target_position - parent_.global_position

func get_target_position():
	if player_ref == null:
		return global_position
	var dir = (parent_.global_position - player_ref.global_position).normalized()
	return player_ref.global_position + _actual_target_range * dir
