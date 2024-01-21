class_name EntityBirth
extends Node2D

signal start_birth(scene, pos)

@onready var animation_player = $AnimationPlayer as AnimationPlayer
var entity_scene
var birth_pos

func set_birth_info(p_entity_scene, p_birth_pos):
	entity_scene = p_entity_scene
	birth_pos = p_birth_pos
	
func spawn_entity():
	emit_signal("start_birth", entity_scene, birth_pos)
	queue_free()
