extends Node
class_name MinerAI

export(int) var speed = 8

const ROTATE_SPEED = 5
var current_path_index: int = 0
var path: Array = []
var velocity = Vector3.ZERO

func build_path(nav, target, door: String = "Door"):
	var posObj = target.get_node(door)
	current_path_index = 1
	path = nav.get_simple_path(owner.global_transform.origin, posObj.global_transform.origin)
	pass


func move_to_target(delta, target_threshold: float = 0.5, align = true):
	if current_path_index >= path.size():
		return
	var dir:Vector3 = path[current_path_index] - owner.global_transform.origin
	if is_within_target_threshold(path[current_path_index], owner.global_transform.origin, target_threshold):
		current_path_index += 1
	else:
		var _vel = dir.normalized() * speed
		velocity = owner.move_and_slide(_vel)
		rotate_to_direction(delta, velocity)


func is_within_target_threshold(target_pos, current_pos,target_threshold: float = 0.5) -> bool:
	var dir = target_pos - current_pos
	return dir.length() <= target_threshold


func rotate_to_direction(delta, _vel):
	var t = owner.global_transform
	var lp = t.origin + _vel.normalized()
	var lookatpos = lp
	var l = t.looking_at(lookatpos, Vector3(0,1,0))
	var a = Quat(t.basis)
	var b = Quat(l.basis)
	var c = a.slerp(b, ROTATE_SPEED * delta)
	owner.global_transform.basis = Basis(c)
	pass
