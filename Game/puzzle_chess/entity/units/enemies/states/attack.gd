@tool
extends FSMState


# Executes after the state is entered.
func _on_enter(_actor, _blackboard: Blackboard):
	# play attack animation
	_actor = _actor as Enemy
	_actor.animation_player.play("attack")
	pass


# Executes every _process call, if the state is active.
func _on_update(_delta, _actor, _blackboard: Blackboard):
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
