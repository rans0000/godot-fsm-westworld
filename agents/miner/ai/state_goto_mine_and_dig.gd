extends State

const DEBUG = Game.DEBUG || false
var fsm: StateMachine
var target = null
var is_reached_mine = false
var is_digging_mine = false



func enter():
	is_reached_mine = false
	is_digging_mine = false
	if DEBUG: print("enter: walk to mine")
	target = Game.mines[0]
	owner.ai.build_path(owner.nav, target)
	owner.playback.travel("anim_walk-loop")
	pass


func physics_process(delta):
	if not is_reached_mine:
		var velocity = owner.ai.move_to_target(delta, "miner_reached_mine")
		owner.ai.rotate_to_direction(delta, velocity)
	elif is_reached_mine and not is_digging_mine:
		owner.playback.travel("anim_digging")
		is_digging_mine = true
	elif is_reached_mine and is_digging_mine:
		if owner.thirst > 50 :
			print("thirsty")
			owner.thirst = 0
		if owner.has_enough_gold():
			fsm.change_state_to(owner.states.STATE_GOTO_HOME)
	pass


func exit():
	target = null
	is_reached_mine = false
	is_digging_mine = false
	if DEBUG: print("exit-state walk mine")
	pass


func on_message(_message_data):
	match _message_data.name:
		"miner_reached_mine":
			is_reached_mine = true
	pass
