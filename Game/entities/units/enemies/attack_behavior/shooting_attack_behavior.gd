class_name ShootingAttackBehavior 
extends AttackBehavior

@onready var projectile_scene = preload("res://projectiles/bullet_enemy/enemy_projectile.tscn")
@export var cooldown : int = 10
@export var min_range : int = 0
@export var max_range : int = 500

@onready var _current_cd:float = 3

var player_ref:Node2D = null

func init(parent:Node)->Node:
	var _init = super.init(parent)
	player_ref = (parent_ as Unit).player_ref_
	return self

func _physics_process(delta):
	_current_cd = max(_current_cd - delta, 0)
	if _current_cd <= 0 and Utils.is_between(parent_.global_position.distance_to(player_ref.global_position), min_range, max_range):
		parent_.animation_player_.play("shoot")
		_current_cd = cooldown

func get_target_position():
	if player_ref != null:
		return player_ref.global_position
	else: 
		return parent_.global_position

func shoot():
	var target_position = player_ref.global_position
	var p_rotation = global_position.angle_to_point(target_position)
	var projectile = WeaponService.spawn_projectile(projectile_scene, p_rotation, global_position, 0.5, 1) as EnemyProjectile
	projectile.set_damage(1)
	pass
