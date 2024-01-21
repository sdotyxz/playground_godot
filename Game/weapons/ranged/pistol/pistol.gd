class_name Pistol
extends Weapon

@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var mazz = $Mazz as Node2D

@onready var projectile_scenes : Array = [
	preload("res://projectiles/bullet/bullet_projectile.tscn"),
	preload("res://projectiles/bullet/pistol/pistol_bullet_lv1.tscn"),
	preload("res://projectiles/bullet/pistol/pistol_bullet_lv2.tscn"),
	preload("res://projectiles/bullet/pistol/pistol_bullet_lv3.tscn")
]

func shoot():
	if animation_player.is_playing():
		return
	animation_player.play("fire")

func pistol_fire():
	shooting_behavior_.shoot(150)
	Ammo -= everyshootreduceAmmo
	emit_signal("ammo_changed", Ammo)

func get_mazz_position() -> Vector2:
	return mazz.global_position

func get_projectile_scene() -> PackedScene:
	return projectile_scenes[cur_overload_level]
