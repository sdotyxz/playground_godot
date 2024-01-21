extends GPUParticles2D

func _on_destory_timer_timeout():
	queue_free()
