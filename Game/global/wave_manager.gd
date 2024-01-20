class_name WaveManager
extends Node

signal group_spawn_timing_reached(group_id:String)
signal wave_started(wave_index:int)

@onready var wave_timer_ : Timer = $WaveTimer

var current_difficulty_ : int = 1
var current_wave_index_ : int = 0
var current_wave_id : String = ""
var last_time_checked_ : int = 0
var next_spawn_time_ : int = 0

func init(difficulty:int):
	current_difficulty_ = difficulty
	current_wave_index_ = 0
	start_wave()

func _physics_process(delta):
	if wave_timer_.is_stopped():
		return	
	
	var time_left = wave_timer_.time_left as int
	if time_left != last_time_checked_ :
		print("time_left ", time_left)
		last_time_checked_ = time_left
		var groups = ConfigService.get_group_configs(current_wave_id)
		var cur_time = wave_timer_.wait_time - wave_timer_.time_left
		for group in groups:
			if group.timing >= cur_time:
				if cur_time > next_spawn_time_:
					print("group_spawn_timing_reached ", group.id)
					emit_signal("group_spawn_timing_reached", group.id)
					next_spawn_time_ = cur_time + group.interval
				break

func start_wave():
	last_time_checked_ = 0
	next_spawn_time_ = 0
	var waves : Array = ConfigService.get_wave_configs(current_difficulty_)
	if waves.size() > 0:
		var wave_index = clampi(current_wave_index_, 0, waves.size() - 1)
		var current_wave = waves[wave_index]
		current_wave_id = current_wave.id
		wave_timer_.start(current_wave.duration)
		emit_signal("wave_started", current_wave_index_)

func _on_wave_timer_timeout():
	print("Current Wave End")
	current_wave_index_ += 1
	start_wave()
	pass # Replace with function body.
