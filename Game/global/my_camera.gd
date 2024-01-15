extends Camera2D

var center_horizontal_ = false
var center_vertical_ = false
var center_horizontal_pos_:int
var center_vertical_pos_:int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if center_horizontal_:
		global_position.x = center_horizontal_pos_
	if center_vertical_:
		global_position.y = center_vertical_pos_
