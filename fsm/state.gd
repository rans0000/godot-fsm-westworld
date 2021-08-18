extends Node
class_name State

onready var Game = get_node("/root/Game")

var fsm: StateMachine


func enter():
	if Game.DEBUG:
		print("Entering state")
	pass


func exit(next_state):
	fsm.change_state_to(next_state)


func process(_delta):
	pass


func physics_process(_delta):
	pass


func input(_event):
	pass


func unhandled_input(_event):
	pass


func unhandled_key_input(_event):
	pass


func notification(_what, _flag = false):
	pass
