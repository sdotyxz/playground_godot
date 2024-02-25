class_name Match3Grid
extends Node2D

# define enum of match3 game state
enum State {
	wait,
	move
}

var state = State.move

var destroy_timer = Timer.new()
var collapse_timer = Timer.new()
var refill_timer = Timer.new()

# define a dictionary dot type as key and scene as value
@onready var dot_dict = {
	Dot.DotType.SQUARE : preload("res://puzzle_chess/entity/dots/dot_square.tscn"),
	Dot.DotType.CIRCLE : preload("res://puzzle_chess/entity/dots/dot_circle.tscn"),
	Dot.DotType.TRIANGLE : preload("res://puzzle_chess/entity/dots/dot_triangle.tscn"),
	Dot.DotType.DIAMOND : preload("res://puzzle_chess/entity/dots/dot_diamond.tscn"),
}

@onready var tile_map : TileMap = $TileMap

@onready var effectors = [
	$UpgradeMatch
]

@export var width = 20
@export var height = 20

# define start point 
var start_point = Vector2i(20, 7)

# define block rect
var block_rect = Rect2(26, 15, 8, 4)

var all_dots = []

var current_matches = []

var first_touch = Vector2i(0,0)
var final_touch = Vector2i(0,0)
var controlling = false

# Called when the node enters the scene tree for the first time.
func _ready():
	state = State.move
	setup_timer()
	randomize()
	all_dots = make_2d_array()
	spawn_dots()
	find_all_matches()
	pass # Replace with function body.

# setup timer
func setup_timer():
	destroy_timer.set_wait_time(0.2)
	destroy_timer.set_one_shot(true)
	destroy_timer.connect("timeout", Callable(self, "destroy_matches"))
	add_child(destroy_timer)

	collapse_timer.set_wait_time(0.2)
	collapse_timer.set_one_shot(true)
	collapse_timer.connect("timeout", Callable(self, "collapse_columns"))
	add_child(collapse_timer)

	refill_timer.set_wait_time(0.2)
	refill_timer.set_one_shot(true)
	refill_timer.connect("timeout", Callable(self, "refill_columns"))
	add_child(refill_timer)

# restricted fill
func restricted_fill(column, row):
	var fill_point = start_point + Vector2i(column, row)
	if block_rect.has_point(fill_point):
		return true
	return false

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
			spawn_dot_at(i, j)

# spawn dot at coulmn and row
func spawn_dot_at(column, row):

	if restricted_fill(column, row):
		return
	
	var dot_point = start_point + Vector2i(column, row)
	var dot_type = randi() % Dot.DotType.MAX
	var loop_count = 0
	while match_at(column, row, dot_type) && loop_count < 100:
		dot_type = randi() % Dot.DotType.MAX
		loop_count += 1
	var dot : Dot = dot_dict[dot_type].instantiate()
	dot.position = tile_map.map_to_local(dot_point)
	add_child(dot)
	all_dots[column][row] = dot

# check match at column and row
func match_at(column, row, dot_type):
	if column > 1:
		var dot_left_1 : Dot = all_dots[column - 1][row]
		var dot_left_2 : Dot = all_dots[column - 2][row]
		var dots_valid = dot_left_1 != null && dot_left_2 != null
		if dots_valid && dot_left_1.dot_type == dot_type && dot_left_2.dot_type == dot_type:
			return true
	if row > 1:
		var dot_up_1 : Dot = all_dots[column][row - 1]
		var dot_up_2 : Dot = all_dots[column][row - 2]
		var dots_valid = dot_up_1 != null && dot_up_2 != null
		if dots_valid && dot_up_1.dot_type == dot_type && dot_up_2.dot_type == dot_type:
			return true
	return false

# convert grid to world position
func grid_to_world_position(column, row):
	var tile_map_point = start_point + Vector2i(column, row)
	return tile_map.map_to_local(tile_map_point)

# convert world position to grid
func world_position_to_grid(world_position):
	var tile_map_point = tile_map.local_to_map(world_position)
	return tile_map_point - start_point

# check if the grid point in grid
func is_in_grid(column, row):
	return column >= 0 and column < width and row >= 0 and row < height

# process touch input
func touch_input():
	var touch_position = get_global_mouse_position()
	var grid_position = world_position_to_grid(touch_position)
	var touch_pos_in_grid = is_in_grid(grid_position.x, grid_position.y)
	if Input.is_action_just_pressed("ui_touch"):
		if touch_pos_in_grid:
			first_touch = grid_position
			controlling = true
	if Input.is_action_just_released("ui_touch"):
		if touch_pos_in_grid && controlling:
			final_touch = grid_position
			controlling = false
			# log first touch and final touch with comment
			print("first touch: ", first_touch, "final touch: ", final_touch)
			touch_diff(first_touch, final_touch)
		pass
	pass

# swap dots
func swap_dots(column, row, direction):
	var first_dot = all_dots[column][row]
	var other_dot = all_dots[column + direction.x][row + direction.y]
	if first_dot != null && other_dot != null:
		# state = State.wait
		all_dots[column][row] = other_dot
		all_dots[column + direction.x][row + direction.y] = first_dot
		var first_dot_position = first_dot.position
		var other_dot_position = other_dot.position
		first_dot.move(other_dot_position)
		other_dot.move(first_dot_position)
		find_all_matches()

# handle touch diffence
func touch_diff(grid_1, grid_2):
	var diff = grid_2 - grid_1
	# if diff abs x > abs y
	if abs(diff.x) > abs(diff.y):
		if diff.x > 0:
			swap_dots(grid_1.x, grid_1.y, Vector2i(1, 0))
		elif diff.x < 0:
			swap_dots(grid_1.x, grid_1.y, Vector2i(-1, 0))
	elif abs(diff.x) < abs(diff.y):
		if diff.y > 0:
			swap_dots(grid_1.x, grid_1.y, Vector2i(0, 1))
		elif diff.y < 0:
			swap_dots(grid_1.x, grid_1.y, Vector2i(0, -1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == State.move:
		touch_input()
	pass

# check grid dot is null
func is_grid_null(column, row):
	return all_dots[column][row] == null

# get dot at column and row
func get_dot_at(column, row):
	return all_dots[column][row]

func find_all_matches():
	# log find all matches
	print("find_all_matches")
	current_matches = []
	var in_column_matches_grids = []
	var in_row_matches_grids = []
	for i in width:
		for j in height:
			var dot = all_dots[i][j]
			
			if dot == null:
				continue

			if in_column_matches_grids.find(Vector2i(i, j)) == -1:			
				var match_array_right = [Vector2i(i, j)]
				find_match_at_right(i, j, match_array_right)
				if match_array_right.size() >= 3:
					current_matches.append(match_array_right)
					# append all dots in match array to in matches dots
					for match_grid in match_array_right:
						in_column_matches_grids.append(match_grid)
			
			if in_row_matches_grids.find(Vector2i(i, j)) == -1:
				var match_array_down = [Vector2i(i, j)]
				find_match_at_down(i, j, match_array_down)
				if match_array_down.size() >= 3:
					current_matches.append(match_array_down)
					# append all dots in match array to in matches dots
					for match_grid in match_array_down:
						in_row_matches_grids.append(match_grid)
	
	# set all dots in matches to matched
	for match_array in current_matches:
		process_match_array(match_array)
	
	destroy_timer.start()

func find_match_at_right(column, row, match_array):
	var dot : Dot = all_dots[column][row]
	if column < width - 1:
		var right_dot = all_dots[column + 1][row]
		if right_dot != null && dot.compare(right_dot) :
			match_array.append(Vector2i(column + 1, row))
			find_match_at_right(column + 1, row, match_array)

func find_match_at_down(column, row, match_array):
	var dot : Dot = all_dots[column][row]
	if row < height - 1:
		var down_dot = all_dots[column][row + 1]
		if down_dot != null && dot.compare(down_dot) :
			match_array.append(Vector2i(column, row + 1))
			find_match_at_down(column, row + 1, match_array)

func process_match_array(match_array):
	# log match array with comment
	print("match_array: ", match_array)
	for match_grid in match_array:
		var dot = all_dots[match_grid.x][match_grid.y]
		if dot == null:
			continue
		dot.matched = true
		dot.dim()

func destroy_matches():
	# create match effect from current matches
	for match_array in current_matches:
		# loop effectors create effect
		for effector : Match3Effector in effectors:
			effector.process(self, match_array)
		pass

	# destroy all dots in matches
	for i in width:
		for j in height:
			var dot = all_dots[i][j] as Dot
			if dot != null && dot.matched:
				dot.queue_free()
				all_dots[i][j] = null
	
	collapse_timer.start()

func collapse_columns():
	for i in width:
		for j in height:
			var dot = all_dots[i][j]
			if dot != null:
				continue
			if restricted_fill(i, j):
				continue
			for k in range(j + 1, height):
				var other_dot = all_dots[i][k]
				if other_dot != null:
					all_dots[i][j] = other_dot
					all_dots[i][k] = null
					other_dot.move(grid_to_world_position(i, j))
					break
	refill_timer.start()

func refill_columns():
	for i in width:
		for j in height:
			if all_dots[i][j] != null:
				continue
			spawn_dot_at(i, j)
	after_refill()

func after_refill():
	var has_match = false
	# loop through grid
	for i in width:
		for j in height:
			var dot : Dot = all_dots[i][j]
			if dot != null:
				if match_at(i, j, dot.dot_type):
					has_match = true
					break
	if has_match:
		find_all_matches()
	else:
		state = State.move
