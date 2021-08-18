extends KinematicBody

export(NodePath) var nav_path
export(NodePath) var target_path

onready var nav = get_node(nav_path)
onready var target = get_node(target_path)

var speed = 8 as int
var path = [] as Array
var current_path_index = 0 as int
var target_threshold = 0.5 as float



func _ready():
	update_target()
	pass


func _physics_process(_delta):
	move_to_target()
	pass


func update_target():
	current_path_index = 1
	path = nav.get_simple_path(global_transform.origin, target.global_transform.origin)
	print(path)
	pass


func move_to_target():
	if current_path_index >= path.size():
		return
	var dir:Vector3 = path[current_path_index] - global_transform.origin
	if dir.length() <= target_threshold:
		current_path_index += 1
	else:
		var velocity = dir.normalized() * speed
		var _vel = move_and_slide(velocity)
#	print(dir, " ---- ", dir.length(), " ---- ", current_path_index)
