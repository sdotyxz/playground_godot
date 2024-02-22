extends Node

# define enum for the different types of dot
enum DotType { 
	SQUARE,
	CIRCLE,
	TRIANGLE,
	DIAMOND
}

# export dot type
@export var dot_type : DotType = DotType.SQUARE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
