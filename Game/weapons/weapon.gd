class_name Weapon
extends Node2D

@onready var shooting_behavior_ : WeaponShootingBehavior = $ShootingBehavior

func _ready():
	shooting_behavior_.init(self)

func _physics_process(delta):
	rotation = (get_global_mouse_position() - global_position).angle()

func _input(event : InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot()

func shoot():
	print("shoot")
	shooting_behavior_.shoot(150)
	pass
