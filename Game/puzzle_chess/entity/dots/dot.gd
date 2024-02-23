class_name Dot
extends Node2D

# define enum for the different types of dot
enum DotType { 
	SQUARE,
	CIRCLE,
	TRIANGLE,
	DIAMOND,
	MAX
}

# export dot type
@export var dot_type : DotType = DotType.SQUARE

@onready var sprite : Sprite2D = $Sprite2D

var matched = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# set scale to 0.125
	scale = Vector2(0.125, 0.125)
	pass # Replace with function body.

# move dot
func move(target_position):
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'position', target_position, 0.2)

func dim():
	sprite.modulate = Color(1, 1, 1, 0.5)
