@tool
extends FSMState


# Executes after the state is entered.
func _on_enter(_actor, _blackboard: Blackboard):
	# cast _actor to soldier
	_actor = _actor as Soldier

	# play move animation
	_actor.animation_player.play("move")
	pass


# Executes every _process call, if the state is active.
func _on_update(_delta, _actor, _blackboard: Blackboard):
	# cast _actor to soldier
	_actor = _actor as Soldier
	if _actor.has_chase_target():
		_actor.set_target_position(_actor.chase_target.position)
	pass


# Executes before the state is exited.
func _on_exit(_actor, _blackboard: Blackboard):
	_actor = _actor as Soldier
	_actor.set_target_position(_actor.position)
	pass


# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	# Add your own warnings to the array here

	return warnings
