extends Node2D

var dragging = false
var tilemap = null

# Called when the node enters the scene tree for the first time.
func _ready():
    tilemap = get_node("/root/gameplay/main_level/TileMap") # Replace with your TileMap path
    set_process_input(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
    if event is InputEventMouseButton:
        if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
            # print the mouse position
            print(get_local_mouse_position())
            if get_viewport_rect().has_point(get_local_mouse_position()):
                dragging = true
        elif not event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
            dragging = false
    elif event is InputEventMouseMotion and dragging:
        var tile = tilemap.world_to_map(tilemap.to_local(get_global_mouse_position()))
        position = tilemap.map_to_world(tile) + tilemap.cell_size / 2
        print(position)