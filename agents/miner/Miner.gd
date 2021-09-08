extends KinematicBody

export(NodePath) var navigation_node
export(NodePath) var home_node

var velocity = Vector3.ZERO
var target_reached = false
var gold = 0
var thirst = 0

onready var nav = get_node(navigation_node)
onready var home = get_node(home_node)
onready var anim_tree = $AnimationTree
onready var playback = $AnimationTree.get("parameters/StateMachine/playback")
onready var ai = $AI
onready var fsm = $FSM
onready var states  = {
	"STATE_GOTO_MINE": $FSM/StateGotoMine,
	"STATE_DIG_AT_MINE": $FSM/StateDigAtMine,
	"STATE_GOTO_HOME": $FSM/StateGotoHome
}



func _ready():
	playback.start("anim_stand_straight-loop")
	ai.connect("target_reached", fsm, "handle_messages")
	pass


func _physics_process(_delta):
	pass


func set_target_reached(status: bool):
	target_reached = status


func is_target_reached() -> bool:
	return target_reached


func dig_gold(_gold: int, _thirst: int):
	gold += _gold
	thirst += _thirst


func get_gold():
	return gold


func set_gold(amount):
	gold = amount


func has_enough_gold():
	return gold >= 20
