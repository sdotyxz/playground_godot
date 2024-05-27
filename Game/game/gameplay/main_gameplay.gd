extends Node2D

# export level object
@export var level_object : PackedScene

@onready var main_level : MainLevel = $main_level
@onready var objects : Node2D = $objects
@onready var task_timer : Timer = $task_timer

# task array
var tasks = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# log hello world
	print("Hello, World!")
	StartGame()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tasks.size() == 0:
		return
	# check if the task is completed
	if CheckTaskCompleted():
		# game win
		GameWin()
	pass

# function to check if the task is completed
func CheckTaskCompleted():
	var all_completed = true
	# loop through all tasks
	for task : TaskBase in tasks:
		# if task is not completed break the loop
		if not task.validate_task_completed():
			all_completed = false
			break
	return all_completed

# function Start Playing the Game
func StartGame():
	# spawn draggable object
	var new_level_object = level_object.instantiate() as LevelObject
	objects.add_child(new_level_object)
	new_level_object.set_tilemap(main_level.get_tilemap(), Vector2(1, 1))

	# create a task
	var task = TaskMoveObject.new()
	task.init_task([new_level_object, Vector2(0, 0)])
	tasks.append(task)

	# start timer
	task_timer.start()
	pass

# function Game Win
func GameWin():
	# stop timer
	task_timer.stop()

	# clear tasks
	tasks.clear()

	# show win message
	print("You Win!")
	pass

# function Game Over
func GameOver():
	# stop timer

	# clear tasks
	tasks.clear()

	# show game over message
	print("Game Over!")
	pass


func _on_task_timer_timeout():
	GameOver()
	pass # Replace with function body.
