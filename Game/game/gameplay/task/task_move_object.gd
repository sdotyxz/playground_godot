class_name TaskMoveObject
extends TaskBase

var target_level_object : LevelObject
var target_position : Vector2

# func init task
func init_task(_targets : Array):
    target_level_object = _targets[0] as LevelObject
    target_position = _targets[1] as Vector2

# func validate task completed
func validate_task_completed():
    return target_level_object.get_object_map_position() == target_position