class_name PlayerProjectile
extends Projectile

@export var enable_physics_process = false

func _ready():
	set_physics_process(enable_physics_process)

func _on_hitbox_on_hit_something(thing_hit, damage_dealt):
	print("_on_hitbox_on_hit_something")
	pass # Replace with function body.
