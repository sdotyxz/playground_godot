class_name PlayerProjectile
extends Projectile

@export var enable_physics_process = false
@export var piercing : int = 2

@onready var hitbox = $Hitbox as Hitbox

func _ready():
	set_physics_process(enable_physics_process)
	
func set_damage(damage):
	hitbox.set_damage(damage)

func _on_hitbox_on_hit_something(thing_hit, damage_dealt):
	print("_on_hitbox_on_hit_something")
	piercing = max(0, piercing - 1)
	if piercing <= 0 :
		hitbox.disable()
		queue_free()
	pass # Replace with function body.
