extends Node

func instance_scene_on_main(scene:PackedScene, position:Vector2)->Node:
	var main = get_tree().current_scene
	var instance = scene.instantiate()
	main.add_child(instance)

	if "global_position" in instance:
		instance.global_position = position
	elif "rect_position" in instance:
		instance.rect_position = position

	return instance

func vectors_approx_equal(a:Vector2, b:Vector2, precision:float)->bool:
	return a.distance_to(b) <= precision

func is_between(number:int, min_value:int, max_value:int, including: = true)->bool:
	if including:
		return number >= min_value and number <= max_value
	else :
		return number > min_value and number < max_value
