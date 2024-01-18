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
