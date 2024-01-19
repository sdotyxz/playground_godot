class_name RangedWeaponShootingBehavior
extends WeaponShootingBehavior

signal projectile_shot(projectile)

@export var projectile_spread = PI/4#散射角度
@export var projectile_num = 5#同时发射数量
@export var weaponType = 2#1-单发 2-喷子 3-冲锋枪
@export var projectile_v = 1.0#子弹速度
@export var projectile_lifetime = 1.0#子弹生命周期
var level = 1

func shoot(_distance:float)->void :

	shoot_projectile()
	pass

func shoot_projectile(rotation:float = parent_.rotation, knockback:Vector2 = Vector2.ZERO)->void :
	
	if 		weaponType == 1:#1-单发
		WeaponService.spawn_projectile(rotation, parent_.global_position, projectile_v)
	
	
	elif  	weaponType == 2:#2-喷子
		for i in projectile_num:
			var _spread_rotation = randf_range(rotation+projectile_spread, rotation-projectile_spread)
			WeaponService.spawn_projectile(rotation, parent_.global_position, projectile_v)
			#print(i)
	
	elif	weaponType == 3:#3-冲锋枪
		var _spread_rotation = randf_range(rotation+projectile_spread, rotation-projectile_spread)
		var a = 0
		if  a <= projectile_num:
			a += 1
			WeaponService.spawn_projectile(rotation, parent_.global_position, projectile_v)
		else:
			pass
	
	else:
		pass
	

