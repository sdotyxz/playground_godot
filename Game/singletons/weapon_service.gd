extends Node

func spawn_projectile(
	projectile_scene:PackedScene,
	rotation:float,
	pos:Vector2, 
	speed:float,
	size:float,
) -> Node :
	var projectile : Projectile
	projectile = Utils.instance_scene_on_main(projectile_scene, pos)
	projectile.velocity_ = Vector2.RIGHT.rotated(rotation) * (1000 * speed)
	projectile.rotation = projectile.velocity_.angle()
	projectile.scale = Vector2(1,1) * size
	return projectile
