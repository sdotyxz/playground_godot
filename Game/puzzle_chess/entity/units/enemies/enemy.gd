class_name Enemy
extends Unit

var attack_target: Soldier = null

func _ready():
	# call super
	super._ready()
	set_target_position(Vector2.ZERO)

# block by solider
func block_by_solider(soldier: Soldier):
	set_attack_target(soldier)
	pass

# set attack target
func set_attack_target(target: Soldier):
	attack_target = target

# has attack target
func has_attack_target() -> bool:
	return attack_target != null