extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():

	# Get the tilemap
	var tilemap = get_node("TileMap") as TileMap

	# Get the level object
	var level_object = get_node("LevelObject") as Node2D

	# get tilemap (0, 0) local position
	var tilemap_position = tilemap.map_to_local(Vector2(0, 0))

	# set level object position to tilemap (0, 0) local position
	level_object.position = tilemap_position
