extends Node2D

# possible dots
@onready var possible_dots = [
	preload("res://puzzle_chess/entity/dots/dot_square.tscn"),
	preload("res://puzzle_chess/entity/dots/dot_circle.tscn"),
	preload("res://puzzle_chess/entity/dots/dot_triangle.tscn"),
	preload("res://puzzle_chess/entity/dots/dot_diamond.tscn"),
]

@onready var tile_map : TileMap = $TileMap

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
	# define dot start point value to 20, 7
	var start_point = Vector2(20, 7)
	# define block rect
	var block_rect = Rect2(26, 15, 8, 4)

	for i in width:
		for j in height:
			var dot = possible_dots[randi() % possible_dots.size()].instantiate()

			# define dot point
			var dot_point = start_point + Vector2(i, j)

			# check if the dot point is in the block rect
			if block_rect.has_point(dot_point):
				continue

			dot.position = tile_map.map_to_local(dot_point)
			dot.scale = Vector2(0.125, 0.125)

			add_child(dot)
			all_dots[i][j] = dot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	touch_input()
	pass

# process touch input
func touch_input():
	if Input.is_action_just_pressed("ui_touch"):
		pass
	if Input.is_action_just_released("ui_touch"):
		pass
	pass