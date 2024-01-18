class_name EntitySpawner
extends Node

signal player_spawned(player)

@export var player_scene : PackedScene
@export var enemy_secene : PackedScene

var player_ : Player = null
var entities_container_ : Node2D = null
var zone_min_pos_ : Vector2 = Vector2.ZERO
var zone_max_pos_ : Vector2 = Vector2.ZERO

func init(
	entities_container : Node2D,
	zone_min_pos : Vector2,
	zone_max_pos : Vector2
)->void:
	entities_container_ = entities_container	
	zone_min_pos_ = zone_min_pos
	zone_max_pos_ = zone_max_pos
	player_ = spawn_entity(player_scene, Vector2(zone_max_pos.x / 2, zone_max_pos.y / 2), true)
	emit_signal("player_spawned", player_)
	
	spawn_entity(enemy_secene, Vector2(randf_range(0, zone_max_pos.x), randf_range(0, zone_max_pos.y)))

func spawn_entity(scene:PackedScene, pos:Vector2, is_player:bool = false, data:Resource = null)->CharacterBody2D:
	var entity = scene.instantiate()

	entity.global_position = pos

	#if data:
		#entity.set_data(data)

	entities_container_.add_child(entity)

	#if is_player:
		#entity.apply_items_effects()

	entity.init(zone_min_pos_, zone_max_pos_, player_, self)

	return entity
