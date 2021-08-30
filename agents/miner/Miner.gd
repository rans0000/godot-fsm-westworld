extends KinematicBody

export(NodePath) var navigation_node
export(NodePath) var mine_node

var velocity = Vector3.ZERO
var target_reached = false

onready var nav = get_node(navigation_node)
onready var target = get_node(mine_node)
onready var anim_tree = $AnimationTree
onready var playback = $AnimationTree.get("parameters/StateMachine/playback")
onready var ai = $MinerAI
onready var fsm = $FSM
onready var states  = {
	"STATE_MINER_TRAVEL_TO_MINE": $StateMachine/StateMinerTravelToMine
}



func _ready():
	playback.start("anim_stand_straight-loop")
	ai.connect("target_reached", self, "on_reach_mine")
	pass


func _physics_process(_delta):
	pass


func set_target_reached(status: bool):
	target_reached = status


func is_target_reached() -> bool:
	return target_reached


func on_reach_mine(_target, _owner):
	fsm.state.exit("rrrr")
	pass
