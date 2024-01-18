class_name Hurtbox
extends Area2D

@onready var collision_ : CollisionShape2D = $Collision

func is_disabled()->bool:
	return collision_.disabled

func enable()->void :
	collision_.set_deferred("disabled", false)


func disable()->void :
	collision_.set_deferred("disabled", true)
