class_name Projectile
extends Node2D

var velocity_ = Vector2.ZERO

@onready var destory_timer_ : Timer = $DestroyTimer

func _physics_process(delta):
	position += velocity_ * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	destory_timer_.start()

func _on_destroy_timer_timeout():
	print("destroy projectile")
	queue_free()
