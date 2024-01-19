extends Node

@onready var wave_config_data = preload("res://configs/wave_config.csv")
@onready var group_config_data = preload("res://configs/group_config.csv")
@onready var unit_config_data = preload("res://configs/unit_config.csv")

func get_wave_configs(difficulty:int) -> Array:
	var waves = []
	for record in wave_config_data.records :
		if record.difficulty == difficulty:
			waves.push_back(record)
	return waves

func get_group_configs(wave_id:String) -> Array:
	var groups = []
	for record in group_config_data.records :
		if record.wave_id == wave_id:
			groups.push_back(record)
	return groups

func get_unit_configs(group_id:String) -> Array:
	var units = []
	for record in unit_config_data.records :
		if record.group_id == group_id:
			units.push_back(record)
	return units
