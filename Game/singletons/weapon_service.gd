extends Node

const DEFAULT_PROJECTILE_SCENE = preload("res://projectiles/bullet/bullet_projectile.tscn")

func spawn_projectile(
	rotation:float,
	pos:Vector2, 
	speed:float,
) -> Node :
	var projectile : Projectile
	projectile = Utils.instance_scene_on_main(DEFAULT_PROJECTILE_SCENE, pos)
	projectile.velocity_ = Vector2.RIGHT.rotated(rotation) * (1000 * speed)
	projectile.rotation = projectile.velocity_.angle()
	return projectile
