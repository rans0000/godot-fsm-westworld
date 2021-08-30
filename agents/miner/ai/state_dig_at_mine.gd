extends Node

var fsm: StateMachine
var checking = false


func enter():
	print("enter: digging")
	owner.playback.travel("anim_digging")
	pass


func physics_process(_delta):
	exit()
	pass


func exit():
	print("exit-state: dig")
	fsm.change_state_to(owner.states.STATE_TRAVEL_TO_HOME)
	pass
