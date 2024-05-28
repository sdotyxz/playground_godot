class_name StoryPanel
extends Panel

@onready var animation_player = $story_panel_animation as AnimationPlayer

# func play slide in animation
func play_slide_in_animation():
	animation_player.play("slide_in")