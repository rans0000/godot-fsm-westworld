extends Node

var fsm: StateMachine


func enter():
	print("move to mine if not at mine")
	print("start mining")
	yield(get_tree().create_timer(2.0), "timeout")
	exit("StateMoveToAndDrink")


func physics_process(_delta):
	print("im mining")


func exit(next_state):
	print("mining finished")
	fsm.change_state_to(next_state)
