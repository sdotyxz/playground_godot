class_name Enemy
extends Unit

@export var material_scene : PackedScene
@export var damage : int = 1
@export var max_health : int = 1

@onready var hitbox = $Hitbox as Hitbox

var health : int = 1

func init(zone_min_pos:Vector2, zone_max_pos:Vector2, p_player_ref:Node2D = null, entity_spawner_ref = null) -> void:
	hitbox.set_damage(damage)
	health = max_health
	super.init(zone_min_pos, zone_max_pos, p_player_ref, entity_spawner_ref)

func take_damage(value:int, hitbox:Hitbox) -> void :
	health = maxi(0, health - value)
	if health <= 0:
		die()
	pass
