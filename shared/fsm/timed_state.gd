extends State
class_name TimedState

@export var min_time: float
@export var max_time: float

@export var state_progress_indicator: NodePath
@onready var _state_progress_indicator_node: Range = get_node(state_progress_indicator)

@export var next_state: NodePath
@onready var next_state_node: State = get_node(next_state) if next_state != null else null

var timer: SceneTreeTimer
var wait_time: float


func _ready() -> void:
	assert(min_time > 0)
	assert(max_time > 0)

	assert(state_progress_indicator != null)
	assert(_state_progress_indicator_node != null)


func enter(_msg: Dictionary = {}) -> void:
	super.enter(_msg)

	_state_progress_indicator_node.visible = true

	wait_time = min_time + randf() * (max_time - min_time)
	print("[%s] Waiting for %f (%f <= x <= %f) seconds." % [name, wait_time, min_time, max_time])
	timer = get_tree().create_timer(wait_time)

	_state_progress_indicator_node.max_value = wait_time

	await timer.timeout

	if next_state_node != null:
		state_machine.transition_to(next_state_node.name)


func update(delta: float) -> void:
	super.update(delta)

	_state_progress_indicator_node.value = timer.time_left


func exit() -> void:
	super.exit()

	_state_progress_indicator_node.visible = false
