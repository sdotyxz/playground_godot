extends Node

@onready var tile_map_ = $TileMap
@onready var tile_map_limits = $TileMapLimits
@onready var camera_ = $Camera
@onready var entity_spawner_ = $EntitySpawner as EntitySpawner
@onready var entities_container_ = $Enitties
@onready var wave_manager_ = $WaveManager as WaveManager

const EDGE_SIZE = 96
const MAP_WIDTH = 30
const MAP_HEIGHT = 30
const TILE_SIZE = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map_.init(MAP_WIDTH, MAP_HEIGHT)
	tile_map_limits.init()
	
	init_camera()
	
	var max_pos = Vector2(MAP_WIDTH * TILE_SIZE, MAP_HEIGHT * TILE_SIZE)
	var min_pos = Vector2.ZERO
	
	entity_spawner_.init(entities_container_, min_pos, max_pos)
	
	wave_manager_.init(1)

	pass # Replace with function body.

func init_camera()->void:
	var max_pos = Vector2(MAP_WIDTH * TILE_SIZE, MAP_HEIGHT * TILE_SIZE)
	var min_pos = Vector2.ZERO
	
	var zone_w = max_pos.x - min_pos.x
	var zone_h = max_pos.y - min_pos.y	
	
	camera_.center_horizontal_pos_ = zone_w / 2
	camera_.center_vertical_pos_ = zone_h / 2
	
	camera_.limit_right = max_pos.x + EDGE_SIZE
	camera_.limit_left = min_pos.x - EDGE_SIZE
	camera_.limit_bottom = max_pos.y + EDGE_SIZE
	camera_.limit_top = min_pos.y - EDGE_SIZE * 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_entity_spawner_player_spawned(player:Player):
	player.get_remote_transform().remote_path = camera_.get_path()
	pass # Replace with function body.


func _on_wave_manager_group_spawn_timing_reached(group_id):
	entity_spawner_.spawn_enemy_group(group_id)
	pass # Replace with function body.

func _on_entity_spawner_enemy_spawned(enemy:Enemy):
	enemy.connect("died", _on_enemy_died)

func _on_enemy_died(enemy:Enemy):
	print("_on_enemy_died Spawn Loot")
	pass
