class_name LevelObject extends Area2D

## Whether or not the object is currently grabbed
var is_grabbed := false

# Helps a bit to make the dragging less choppy
var grabbed_offset := Vector2.ZERO
# Mouse button pressed tracker, used to essentially replicate the behavior of 'is_action_just_released'
var mb_pressed = false

var tilemap : TileMap

@onready var body := get_node("Body") as Sprite2D
@onready var shaodw := get_node("Shadow") as Sprite2D

func _ready() -> void:
	input_event.connect(_on_input_event)

func _physics_process(_delta) -> void:
	# If the input method is down and the object is grabbed, update position
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_grabbed:
		#position = get_global_mouse_position() + grabbed_offset
		position = adjust_position(get_global_mouse_position())
		mb_pressed = true
	
	# Otherwise, if the mouse button was pressed on the previous frame but not isn't, the object is released
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mb_pressed:
		mb_pressed = false
		on_released()


func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	# Detect when mouse button is clicked inside the area2d
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_grabbed = event.is_pressed()
		grabbed_offset = position - get_global_mouse_position()
		on_grabbed()


# adjust the position with tilemap
func adjust_position(_position: Vector2) -> Vector2:
	var tile_size = tilemap.tile_set.tile_size
	# convert tile_size to Vector2
	tile_size = Vector2(tile_size.x, tile_size.y)
	var map_position = clip_tilemap_position(tilemap.local_to_map(_position))
	var adjusted_position = tilemap.map_to_local(map_position)
	return adjusted_position

func clip_tilemap_position(map_position: Vector2i) -> Vector2i:
	var x = clampi(map_position.x, -6, 9)
	var y = clampi(map_position.y, -6, 9)
	return Vector2i(x, y)

func on_grabbed() -> void:
	shaodw.visible = true
	body.modulate = Color(1, 1, 1, 0.75)
	body.offset.y = -60
	tilemap.visible = true

func on_released() -> void:
	shaodw.visible = false
	body.modulate = Color(1, 1, 1, 1)
	body.offset.y = -40
	tilemap.visible = false

# func set tilemap
func set_tilemap(_tilemap: TileMap, _point: Vector2) -> void:
	tilemap = _tilemap

	# get tilemap (0, 0) local position
	var tilemap_position = tilemap.map_to_local(_point)

	# set level object position to tilemap (0, 0) local position
	position = tilemap_position
	