extends Node2D

# export level object
@export var level_object : PackedScene

@onready var main_level : MainLevel = $main_level
@onready var objects : Node2D = $objects

# Called when the node enters the scene tree for the first time.
func _ready():
	# log hello world
	print("Hello, World!")
	StartGame()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# check if the task is completed
	if CheckTaskCompleted():
		# game win
		GameWin()
	else:
		# game over
		GameOver()
	pass

# function to check if the task is completed
func CheckTaskCompleted():
	# check if the draggable object is in the correct position
	pass

# function Start Playing the Game
func StartGame():
	# spawn draggable object
	var new_level_object = level_object.instantiate() as LevelObject
	objects.add_child(new_level_object)
	new_level_object.set_tilemap(main_level.get_tilemap(), Vector2(1, 2))

	# create a task

	# start timer
	pass

# function Game Win
func GameWin():
	# stop timer

	# show win message
	pass

# function Game Over
func GameOver():
	# stop timer

	# show game over message
	pass
