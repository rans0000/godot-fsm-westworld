extends Node

var fsm: StateMachine


func enter():
	print("move to restaurant if not there")
	print("start drinking")
	yield(get_tree().create_timer(2.0), "timeout")
	exit("StateMoveToAndMine")


func physics_process(_delta):
	print("im drinking")


func exit(next_state):
	print("drinking finished")
	fsm.change_state_to(next_state)
