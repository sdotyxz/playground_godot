class_name Weapon
extends Node2D

@onready var shooting_behavior_ : WeaponShootingBehavior = $ShootingBehavior

@export var Ammomax = 1#最大子弹数量
@export var Ammo = 5#现有子弹数量
@export var everyshootreduceAmmo = 1#每次射击消除的子弹数量
@export var bagAmmoMax = 1
@export var bagAmmo = 10#背包子弹数量
@export var pickupAmmo = 1#拾取增加子弹数量
var AmmoClear = 0

@export var overloadState = 1#能力类型


func _ready():
	shooting_behavior_.init(self)

func _physics_process(delta):
	rotation = (get_global_mouse_position() - global_position).angle()
	if Input.is_action_pressed("Key_R"):#換彈
		print("reload")
		reload()

func _input(event : InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if Ammo < 0:#弹夹容量每发减少
				print("noAmmo")
			elif Ammo > 0 :
				shoot()
				Ammo -= everyshootreduceAmmo

func shoot():
	print("shoot")
	shooting_behavior_.shoot(150)
	pass
	
func reload():
	Ammo = bagAmmo #把包裏面的子彈裝入彈夾
	
	if overloadState == 1:#给单发子弹角色，效果是子弹变大
		var overload1 = 9
		var overload2 = 15
		var overload3 = 30
		if Ammo >= overload1 :
			shooting_behavior_.overload_p_size(1)
		elif Ammo >= overload2 :
			shooting_behavior_.overload_p_size(1.5)
		elif Ammo >= overload3 : 
			shooting_behavior_.overload_p_size(2)
		else:
			return

	if overloadState == 2:#给喷子子弹角色，子弹同时发射变多
		var overload1 = 9
		var overload2 = 15
		var overload3 = 30
		if Ammo >= overload1 :
			shooting_behavior_.overload_p_num(7)
		elif Ammo >= overload2 :
			shooting_behavior_.overload_p_num(9)
		elif Ammo >= overload3 : 
			shooting_behavior_.overload_p_num(11)
		else:
			return
	
	if overloadState == 3:#子弹散射变大，双倍发射，未实现
		pass
	
	#bagAmmo = AmmoClear#清空彈夾不成功，使用這個語句后，換彈沒有子彈




func pickup():
	print("pickup")
	bagAmmo += pickupAmmo
