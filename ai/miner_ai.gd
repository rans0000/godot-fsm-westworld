extends Node
class_name MinerAI

export(int) var speed = 8

var current_path_index: int = 0
var path: Array = []

func build_path(nav, target, door: String = "Door"):
	var posObj = target.get_node(door)
	current_path_index = 1
	path = nav.get_simple_path(owner.global_transform.origin, posObj.global_transform.origin)
	pass


func move_to_target(target_threshold: float = 0.5):
	if current_path_index >= path.size():
		return
	var dir:Vector3 = path[current_path_index] - owner.global_transform.origin
	if is_within_target_threshold(path[current_path_index], owner.global_transform.origin, target_threshold):
		current_path_index += 1
	else:
		var velocity = dir.normalized() * speed
		var _vel = owner.move_and_slide(velocity)


func is_within_target_threshold(target_pos, current_pos,target_threshold: float = 0.5) -> bool:
	var dir = target_pos - current_pos
	return dir.length() <= target_threshold
