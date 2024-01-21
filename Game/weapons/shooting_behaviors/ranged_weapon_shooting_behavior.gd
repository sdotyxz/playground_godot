class_name RangedWeaponShootingBehavior
extends WeaponShootingBehavior

signal projectile_shot(projectile)

@export var projectile_spread = PI/4#散射角度
@export var projectile_num = 5#同时发射数量
@export var weaponType = 2#1-单发 2-喷子 3-冲锋枪
@export var projectile_v = 1.0#子弹速度
@export var projectile_lifetime = 1.0#子弹生命周期
@export var projectile_size = 1.0#子弹大小
@export var damage = 1

func shoot(_distance:float)->void :
	shoot_projectile()
	pass

func overload_p_size(p_size:float):#改变子弹大小
	projectile_size = p_size

func overload_p_num(p_num:float):#改变子弹发射数量
	projectile_num = p_num

func shoot_projectile(rotation:float = parent_.rotation, knockback:Vector2 = Vector2.ZERO)->void :
	var mazz_position = parent_.get_mazz_position()
	if weaponType == 1:#1-单发
		var projectile = WeaponService.spawn_projectile(
			rotation, 
			mazz_position, 
			projectile_v,
			projectile_size) as PlayerProjectile
		projectile.set_damage(damage)
	
	elif weaponType == 2:#2-喷子
		for i in projectile_num:#同时发射子弹
			var _spread_rotation = randf_range(rotation+projectile_spread, rotation-projectile_spread)#散射
			var projectile = WeaponService.spawn_projectile(
				_spread_rotation, 
				mazz_position, 
				projectile_v,
				projectile_size) as PlayerProjectile
			projectile.set_damage(damage)
	
	elif weaponType == 3:#3-冲锋枪
		var _spread_rotation = randf_range(rotation+projectile_spread, rotation-projectile_spread)#散射
		var a = 0
		if  a <= projectile_num:
			a += 1
			var projectile = WeaponService.spawn_projectile(
				_spread_rotation, 
				mazz_position, 
				projectile_v,
				projectile_size) as PlayerProjectile
			projectile.set_damage(damage)
		else:
			pass
	else:
		pass
	

