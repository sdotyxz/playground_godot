class_name Player
extends Unit

@onready var leg_right_back = $Animation/Leg_R_Back as Node2D
@onready var leg_left_front = $Animation/Leg_L_Front as Node2D

@onready var leg_right_front = $Animation/Leg_R_Front as Node2D
@onready var leg_left_back = $Animation/Leg_L_Back as Node2D

func get_remote_transform()->RemoteTransform2D:
	return $RemoteTransform2D as RemoteTransform2D
	
func update_animation(movement:Vector2)->void:
	var sprites = $Animation.get_children()
	if movement.x > 0:
		leg_right_back.visible = true
		leg_left_front.visible = true
		
		leg_right_front.visible = false
		leg_left_back.visible = false
		for sprite in sprites:
			sprite.scale.x = abs(sprite.scale.x)
	elif movement.x < 0:
		leg_right_back.visible = false
		leg_left_front.visible = false
		
		leg_right_front.visible = true
		leg_left_back.visible = true
		for sprite in sprites:
			sprite.scale.x = - abs(sprite.scale.x)
			
	if animation_player_.current_animation == "idle" and movement != Vector2.ZERO:
		animation_player_.play("move")
	elif animation_player_.current_animation == "move" and movement == Vector2.ZERO:
		animation_player_.play("idle")
