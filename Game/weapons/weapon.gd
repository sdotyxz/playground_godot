class_name Weapon
extends Node2D

@onready var shooting_behavior_ : WeaponShootingBehavior = $ShootingBehavior

@export var Ammomax = 1#最大子弹数量
@export var Ammo = 5#现有子弹数量
@export var everyshootreduceAmmo = 1#每次射击消除的子弹数量
@export var bagAmmoMax = 1
@export var bagAmmo = 10#背包子弹数量
@export var pickupAmmo = 1#拾取增加子弹数量



@export var overloadState = 1#能力类型
@export var overloadLevel = 1#能力等级
@export var overloadindex = 1#能力参数

func _ready():
	shooting_behavior_.init(self)

func _physics_process(delta):
	rotation = (get_global_mouse_position() - global_position).angle()
	if Input.is_action_pressed("Key_R"):
		print("reload")
		reload()

func _input(event : InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if Ammo < 0:
				print("noAmmo")
			elif Ammo > 0 :
				shoot()
				Ammo -= 1
	
func _overload_Level():
	#if overloadState == 1:#子弹变大
		#pass
	#if overloadState == 2:#子弹同时发射变多
		#var overload1 = 10
		#var overload2 = 20
		#var overload3 = 30
		#if Ammo >= overload1 :
			#overloadindex = 7
		#elif Ammo >= overload2 :
			#overloadindex = 9
		#elif Ammo >= overload3 : 
			#overloadindex = 11
		#else:
			#return
	#if overloadState == 3:#子弹散射变大，双倍发射，未实现
		pass

func shoot():
	print("shoot")
	shooting_behavior_.shoot(150)
	pass
	
func reload():
	Ammo = bagAmmo
	
func pickup():
	print("pickup")
	bagAmmo += pickupAmmo
