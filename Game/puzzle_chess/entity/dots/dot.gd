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

@export var textures : Array[Texture] = []

@onready var sprite : Sprite2D = $Sprite2D

var matched = false

var grade = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# set scale to 0.25
	scale = Vector2(0.25, 0.25)
	pass # Replace with function body.

# move dot
func move(target_position):
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'position', target_position, 0.2)

func dim():
	sprite.modulate = Color(1, 1, 1, 0.5)

func upgrade():
	sprite.modulate = Color(1, 1, 1, 1)
	grade += 1
	sprite.texture = textures[grade]
	matched = false

func compare(dot: Dot):
	if dot_type == dot.dot_type && dot.grade == grade:
		return true
	return false
