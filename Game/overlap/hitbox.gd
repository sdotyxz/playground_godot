class_name Hitbox
extends Area2D

signal on_hit_something(thing_hit, damage_dealt)

@onready var collision_ : CollisionShape2D = $Collision

func hit_something(thing_hit:Node, damage_dealt:int)->void :
	emit_signal("on_hit_something", thing_hit, damage_dealt)

func enable()->void :
	collision_.set_deferred("disabled", false)

func disable()->void :
	collision_.set_deferred("disabled", true)
