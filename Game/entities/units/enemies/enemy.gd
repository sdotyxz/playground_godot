class_name Enemy
extends Unit

@export var material_scene : PackedScene
@export var damage : int = 1
@export var max_health : int = 1

@onready var hitbox = $Hitbox as Hitbox
@onready var shadow = $Animation/Shadow as Sprite2D
@onready var attack_behavior = $AttackBehavior as AttackBehavior

var health : int = 1

func init(zone_min_pos:Vector2, zone_max_pos:Vector2, p_player_ref:Node2D = null, entity_spawner_ref = null) -> void:
	hitbox.set_damage(damage)
	health = max_health
	super.init(zone_min_pos, zone_max_pos, p_player_ref, entity_spawner_ref)
	attack_behavior.init(self)

func take_damage(value:int, hitbox:Hitbox) -> void :
	knockback_direction = hitbox.get_parent().velocity_.normalized() 
	EffectService.play_hit_particles(global_position, knockback_direction, randf_range(5, 7))
	EffectService.play_hit_effect(global_position, knockback_direction, 1)
	health = maxi(0, health - value)
	if health <= 0:
		shadow.visible = false
		attack_behavior.set_physics_process(false)
		die()
	pass

func shoot() -> void:
	attack_behavior.shoot()
	pass
	
func play_idle() -> void:
	animation_player_.play("idle")
