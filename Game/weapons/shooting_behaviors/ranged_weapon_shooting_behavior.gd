class_name RangedWeaponShootingBehavior
extends WeaponShootingBehavior

signal projectile_shot(projectile)

func shoot(_distance:float)->void :
	shoot_projectile()
	pass

func shoot_projectile(rotation:float = parent_.rotation, knockback:Vector2 = Vector2.ZERO)->void :
	WeaponService.spawn_projectile(rotation, parent_.global_position)
	pass
