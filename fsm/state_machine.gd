extends Node
class_name StateMachine

const DEBUG = Game.DEBUG || false
var current_state: Object
var previous_state: Object
var history:Array = []


func _ready():
	yield(get_tree().root, "ready")
	current_state = get_child(0)
	_enter_state()
	pass


func _process(delta):
	if current_state.has_method("process"):
		current_state.process(delta)


func _physics_process(delta):
	if current_state.has_method("physics_process"):
		current_state.physics_process(delta)


func _input(event):
	if current_state.has_method("input"):
		current_state.input(event)


func _unhandled_input(event):
	if current_state.has_method("unhandled_input"):
		current_state.unhandled_input(event)


func _unhandled_key_input(event):
	if current_state.has_method("unhandled_key_input"):
		current_state.unhandled_key_input(event)


func change_state_to(new_state):
#	history.append(current_state.name)
	if(previous_state):
		current_state.exit()
	previous_state = current_state
	current_state = new_state
	_enter_state()
	pass


func _enter_state():
	if Game.DEBUG:
		if DEBUG: print("Entering state: ", current_state.name)
	current_state.fsm = self
	current_state.enter()
	pass


func back():
	if history.size() > 0:
		current_state = get_node(history.pop_back())
		_enter_state()
	pass


func handle_messages(message_data):
	current_state.on_message(message_data)
	pass
