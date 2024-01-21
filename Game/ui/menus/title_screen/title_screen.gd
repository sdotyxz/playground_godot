extends Control

@onready var game_start_timer = $GameStartTimer as Timer

func _on_texture_button_button_up():
	if game_start_timer.is_stopped():
		game_start_timer.start()
	pass # Replace with function body.

func _on_game_start_timer_timeout():
	get_tree().change_scene_to_file("res://ui/menus/wok_selection/wok_selection.tscn")
	pass # Replace with function body.


