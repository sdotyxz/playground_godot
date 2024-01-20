class_name Item
extends Area2D

signal picked_up(item)

var attracted_by_ : Node2D

var current_speed_ : float = 500.0

@onready var sprite_ = $Sprite2D as Sprite2D

func _ready() -> void :
	print("gold spawn")
	#monitorable = false
	pass

func set_texture(texture:Resource) -> void :
	if sprite_ != null :
		sprite_.texture = texture

func attract(attractor) -> void:
	attracted_by_ = attractor

func _physics_process(delta):
	if attracted_by_ != null :
		global_position = global_position.move_toward(attracted_by_.global_position, delta * current_speed_)
		current_speed_ += 20

func pickup() -> void :
	emit_signal("picked_up", self)
	queue_free()
