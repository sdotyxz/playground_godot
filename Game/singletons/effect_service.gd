extends Node

@onready var hit_particles = preload("res://particles/hit_particles.tscn") as PackedScene
@onready var hit_effects = preload("res://visual_effects/hit_effects/hit_effect.tscn") as PackedScene

func play_hit_particles(effect_pos:Vector2, direction:Vector2, effect_scale:float)->void :
	if hit_particles != null:
		play(hit_particles, effect_pos, direction, true, effect_scale)

func play_hit_effect(effect_pos:Vector2, _direction:Vector2, effect_scale:float)->void :
	if hit_effects != null and randf() < effect_scale:
		play(hit_effects, effect_pos, Vector2(randf_range(-1, 1), randf_range(-1, 1)), false, effect_scale)

func play(scene:PackedScene, effect_pos:Vector2, direction:Vector2, is_particle:bool = true, effect_scale:float = 1.0)->void :
	var instance = Utils.instance_scene_on_main(scene, effect_pos)

	if is_particle:
		#instance.amount = max(1, instance.amount * effect_scale)
		instance.emitting = true

	instance.global_position = effect_pos
	instance.rotation = direction.angle() - PI
