class_name PrototypePaperNode2D
extends Sprite2D

var is_dragging = false
var drag_offset = Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				var mouse_pos = get_global_mouse_position()
				if get_rect().has_point(to_local(mouse_pos)):
					is_dragging = true
					drag_offset = mouse_pos - position
			else:
				is_dragging = false

	if event is InputEventMouseMotion and is_dragging:
		position = get_global_mouse_position() - drag_offset
