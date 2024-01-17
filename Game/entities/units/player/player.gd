class_name Player
extends Unit

@export var default_weapon_data : WeaponData

@onready var weapons_container_ = $Weapons

@onready var leg_right_back = $Animation/Leg_R_Back as Node2D
@onready var leg_left_front = $Animation/Leg_L_Front as Node2D

@onready var leg_right_front = $Animation/Leg_R_Front as Node2D
@onready var leg_left_back = $Animation/Leg_L_Back as Node2D

var VISIBLE_COLOR : Color = Color(1, 1, 1, 1)
var INVISIBLE_COLOR : Color = Color(1, 1, 1, 0)

func _ready()->void :
	add_weapon(default_weapon_data)
	super._ready()

func get_remote_transform()->RemoteTransform2D:
	return $RemoteTransform2D as RemoteTransform2D
	
func update_animation(movement:Vector2)->void:
	var sprites = $Animation.get_children()
	if movement.x > 0:
		leg_right_back.modulate = VISIBLE_COLOR
		leg_left_front.modulate = VISIBLE_COLOR
		
		leg_right_front.modulate = INVISIBLE_COLOR
		leg_left_back.modulate = INVISIBLE_COLOR
		for sprite in sprites:
			sprite.scale.x = abs(sprite.scale.x)
	elif movement.x < 0:
		leg_right_back.modulate = INVISIBLE_COLOR
		leg_left_front.modulate = INVISIBLE_COLOR
		
		leg_right_front.modulate = VISIBLE_COLOR
		leg_left_back.modulate = VISIBLE_COLOR
		for sprite in sprites:
			sprite.scale.x = - abs(sprite.scale.x)
			
	if animation_player_.current_animation == "idle" and movement != Vector2.ZERO:
		animation_player_.play("move")
	elif animation_player_.current_animation == "move" and movement == Vector2.ZERO:
		animation_player_.play("idle")

func add_weapon(weapon:WeaponData)->void:
	var instance = weapon.scene.instantiate()
	weapons_container_.add_child(instance)
	instance.global_position = position
	pass
