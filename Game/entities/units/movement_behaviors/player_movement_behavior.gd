class_name PlayerMovementBehavior
extends MovementBehavior

const MIN_MOVE_DIST = 20

var last_movement_ = Vector2.ZERO

func get_movement() -> Vector2:
	var movement:Vector2 = Vector2.ZERO
	movement = Input.get_vector(
		"move_left", 
		"move_right", 
		"move_up", 
		"move_down")
	
	last_movement_ = movement
	
	return movement
