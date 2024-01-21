extends Control

@onready var enter_game_timer = $EnterGameTimer as Timer

func _on_selection_1_button_up():
	if enter_game_timer.is_stopped():
		enter_game_timer.start()
	pass # Replace with function body.

func _on_enter_game_timer_timeout():
	get_tree().change_scene_to_file("res://main.tscn")
	pass # Replace with function body.
