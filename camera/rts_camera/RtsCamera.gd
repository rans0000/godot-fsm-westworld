extends Spatial

export(NodePath) var target_path
onready var target = get_node(target_path)
onready var camera_axis = $CameraAxis

const MAX_SPEED = 270
const VIEWPORT_MARGIN = 50
const ENV_SIZE = 20
var velocity = Vector3.ZERO


func _process(delta):
	var m_pos = get_viewport().get_mouse_position()
#	move_camera(delta, m_pos)
	follow_camera(target)
	rotate_camera(delta, m_pos)
	pass


func move_camera(delta, m_pos):
	var viewport_size = get_viewport().size
	var move_vec = Vector3()
	if m_pos.x < VIEWPORT_MARGIN:
		move_vec.x -= 1
	if m_pos.y < VIEWPORT_MARGIN:
		move_vec.z -= 1
	if m_pos.x > viewport_size.x - VIEWPORT_MARGIN:
		move_vec.x =+ 1
	if m_pos.y > viewport_size.y - VIEWPORT_MARGIN:
		move_vec.z =+ 1
	move_vec = move_vec.rotated(Vector3(0,1,0), rotation_degrees.y)
	global_translate(move_vec * delta * MAX_SPEED)
	pass


func follow_camera(_target):
	if target:
		global_transform.origin = _target.global_transform.origin
	pass


func rotate_camera(delta, m_pos):
	var viewport_size = get_viewport().size
	var move_vec = Vector3()
	if m_pos.x < VIEWPORT_MARGIN:
		move_vec.x -= 1
#	if m_pos.y < VIEWPORT_MARGIN:
#		move_vec.z -= 1
	if m_pos.x > viewport_size.x - VIEWPORT_MARGIN:
		move_vec.x =+ 1
#	if m_pos.y > viewport_size.y - VIEWPORT_MARGIN:
#		move_vec.z =+ 1
#	move_vec = move_vec.rotated(Vector3(0,1,0), rotation_degrees.y)
#	global_translate(move_vec * delta * MAX_SPEED)
	#rotate(move_vec * delta * MAX_SPEED)
	camera_axis.rotate_y(-deg2rad(move_vec.x * delta * MAX_SPEED))
	pass
