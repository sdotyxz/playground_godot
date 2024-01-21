class_name Pistol
extends Weapon

@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var mazz = $Mazz as Node2D

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
