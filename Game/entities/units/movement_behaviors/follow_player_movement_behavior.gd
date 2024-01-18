class_name FollowPlayerMovementBehavior
extends MovementBehavior

var player_ref:Node2D = null

func init(parent:Node)->Node:
	var _init = super.init(parent)
	player_ref = (parent_ as Unit).player_ref_
	return self

func get_movement()->Vector2:
	return get_target_position() - parent_.global_position

func get_target_position():
	return player_ref.global_position
