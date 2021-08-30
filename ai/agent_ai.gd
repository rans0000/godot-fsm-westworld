extends Node
class_name AgentAI

signal target_reached(target, agent)

export(int) var speed = 8

var rotate_speed = 5
var current_path_index: int = 0
var path: Array = []
var target

func build_path(nav, _target, door: String = "Door"):
	var posObj = _target.get_node(door)
	target = _target
	current_path_index = 1
	path = nav.get_simple_path(owner.global_transform.origin, posObj.global_transform.origin)
	pass


func move_to_target(_delta, target_threshold: float = 0.5):
	if current_path_index >= path.size():
		owner.velocity = Vector3.ZERO
		owner.playback.travel("anim_digging")
		emit_signal("target_reached", target, owner)
		return owner.velocity
	var dir:Vector3 = path[current_path_index] - owner.global_transform.origin
	if is_within_target_threshold(path[current_path_index], owner.global_transform.origin, target_threshold):
		current_path_index += 1
		owner.velocity = Vector3.ZERO
	else:
		var _vel = dir.normalized() * speed
		owner.velocity = owner.move_and_slide(_vel)
	return owner.velocity


func is_within_target_threshold(target_pos, current_pos,target_threshold: float = 0.5) -> bool:
	var dir = target_pos - current_pos
	return dir.length() <= target_threshold


func rotate_to_direction(delta, _vel: Vector3, _rot_speed = rotate_speed):
	if _vel.x == 0:
		return
	var t = owner.global_transform
	var lp = t.origin + _vel.normalized()
	var lookatpos = lp
	var l = t.looking_at(lookatpos, Vector3(0,1,0))
	var a = Quat(t.basis)
	var b = Quat(l.basis)
	var c = a.slerp(b, _rot_speed * delta)
	owner.global_transform.basis = Basis(c)
	pass
