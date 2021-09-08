extends State

var fsm: StateMachine
const DEBUG = Game.DEBUG || false


func enter():
	if DEBUG: print("enter: drinking")
	owner.playback.travel("anim_drink")
	pass


func physics_process(_delta):
	pass


func exit():
	if DEBUG: print("exit-state: dig")
	pass
