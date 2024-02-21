extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	# define block rect
	var block_rect = Rect2(26, 15, 8, 4)

	var current_alternative = 0
	# fill tilemap with tile 0 and 1
	for x in range(20, 40):
		for y in range(7, 27):
			# create vectori with x and y
			var tile_point = Vector2i(x, y)
			var tile_id = tile_set.get_source(0).get_tile_id(0)
			
			# check if point is inside block_rect
			if !block_rect.has_point(tile_point):
				# set tile at position to 0
				set_cell(0, tile_point, 0, tile_id, current_alternative)
			
			# set current_alternative to 1 or 0
			current_alternative = 1 - current_alternative
		# set current_alternative to 1 or 0
		current_alternative = 1 - current_alternative
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
