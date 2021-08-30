extends Node
class_name StateMachine

onready var Game = get_node("/root/Game")
var state: Object
var history:Array = []


func _ready():
	yield(get_tree().root, "ready")
	state = get_child(0)
	_enter_state()
	pass


func _process(delta):
	if state.has_method("process"):
		state.process(delta)


func _physics_process(delta):
	if state.has_method("physics_process"):
		state.physics_process(delta)


func _input(event):
	if state.has_method("input"):
		state.input(event)


func _unhandled_input(event):
	if state.has_method("unhandled_input"):
		state.unhandled_input(event)


func _unhandled_key_input(event):
	if state.has_method("unhandled_key_input"):
		state.unhandled_key_input(event)


func change_state_to(new_state):
	history.append(state.name)
#	state = get_node(new_state)
	state = new_state
	_enter_state()
	pass


func _enter_state():
	if Game.DEBUG:
		print("Entering state: ", state.name)
	state.fsm = self
	state.enter()
	pass


func back():
	if history.size() > 0:
		state = get_node(history.pop_back())
		_enter_state()
	pass
