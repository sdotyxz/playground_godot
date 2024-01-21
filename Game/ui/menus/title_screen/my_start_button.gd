extends TextureButton

var is_hover = false

func _on_mouse_entered():
	is_hover = true
	scale = Vector2(1.1, 1.1)

func _on_mouse_exited():
	is_hover = false	
	scale = Vector2(1, 1)	
	
func _on_button_down():
	scale = Vector2(0.9, 0.9)	
	pass # Replace with function body.

func _on_button_up():
	if is_hover:
		scale = Vector2(1.1, 1.1)					
	else:
		scale = Vector2(1, 1)			
