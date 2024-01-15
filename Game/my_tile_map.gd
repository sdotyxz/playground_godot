class_name MyTileMap
extends TileMap

func init(width, height)->void :
	$Outline.size = Vector2(64 * (width + 2), 64 * (height + 3))
	for i in width:
		for j in height:
			my_set_cell(i, j)

func my_set_cell(x:int, y:int)->void :
	var sub_tile_index = randi() % tile_set.get_source(0).get_tiles_count()
	var sub_tile_id = tile_set.get_source(0).get_tile_id(sub_tile_index)
	set_cell(0, Vector2(x, y), 0, sub_tile_id)
