extends Control

@onready var wave_label = $Label
@onready var retry_timer = $RetryTimer as Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	wave_label.text = "%d" % (RunData.final_wave + 1)

func _on_texture_button_button_up():
	if retry_timer.is_stopped():
		retry_timer.start()
	pass # Replace with function body.

func _on_retry_timer_timeout():
	get_tree().change_scene_to_file("res://ui/menus/wok_selection/wok_selection.tscn")
	pass # Replace with function body.
