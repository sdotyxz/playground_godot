@tool
extends FSMState


# Executes after the state is entered.
func _on_enter(_actor, _blackboard: Blackboard):
	# cast actor as solider
	_actor = _actor as Soldier
	_actor.animation_player.play("idle")
	pass


# Executes every _process call, if the state is active.
func _on_update(_delta, _actor, _blackboard: Blackboard):
	# look around to find the enemy
	# if found, check if the enemy is in the attack range
	# if in range, set attact target to the enemy
	# if not in range, set target position to the enemy position
	# if not found, pick a wander position and set target position to the wander position

	# cast actor as solider
	_actor = _actor as Soldier
	_actor.start_wander()
	pass


# Executes before the state is exited.
func _on_exit(_actor, _blackboard: Blackboard):
	pass


# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	# Add your own warnings to the array here

	return warnings

