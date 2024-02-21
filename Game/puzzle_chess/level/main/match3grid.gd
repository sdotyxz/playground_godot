extends Node2D

# possible dots
@onready var possible_dots = [
	preload("res://puzzle_chess/entity/dots/dot_square.tscn"),
	preload("res://puzzle_chess/entity/dots/dot_circle.tscn"),
	preload("res://puzzle_chess/entity/dots/dot_triangle.tscn"),
	preload("res://puzzle_chess/entity/dots/dot_diamond.tscn"),
]

@export var width = 20
@export var height = 20

var all_dots = []

# Called when the node enters the scene tree for the first time.
func _ready():
	all_dots = make_2d_array()
	spawn_dots()
	pass # Replace with function body.


# make 2d array
func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

# spawn dots
func spawn_dots():
	for i in width:
		for j in height:
			var dot = possible_dots[randi() % possible_dots.size()].instantiate()
			dot.position = Vector2(i * 32, j * 32)
			add_child(dot)
			all_dots[i][j] = dot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
