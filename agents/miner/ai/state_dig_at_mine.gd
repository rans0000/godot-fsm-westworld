extends Node

var fsm: StateMachine


func enter():
	print("enter: digging")
	owner.playback.travel("anim_digging")
	pass


func physics_process(_delta):
	exit()
	pass


func exit():
	print("exit-state: dig")
	fsm.change_state_to(owner.states.STATE_GOTO_HOME)
	pass