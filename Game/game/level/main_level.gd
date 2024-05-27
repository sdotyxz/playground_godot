class_name MainLevel
extends Node2D

# function to get the tilemap
func get_tilemap():
	return get_node("TileMap") as TileMap