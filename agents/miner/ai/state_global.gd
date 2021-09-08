extends State

var fsm: StateMachine
const DEBUG = Game.DEBUG || false
var is_going_to_restaurant = false


func enter():
	if DEBUG: print("enter: global")
	pass


func physics_process(_delta) -> bool:
	if owner.is_thirsty() and not is_going_to_restaurant:
		fsm.change_state_to(owner.states.STATE_GOTO_RESTAURANT)
		return true
	return false


func exit():
	is_going_to_restaurant = false
	if DEBUG: print("exit-state: global")
	pass


func on_message(_message_data):
	match _message_data.name:
		"target_reached":
			fsm.history.append(fsm.current_state)
			fsm.change_state_to(owner.states.STATE_DRINK_AT_RESTAURANT)
	pass
