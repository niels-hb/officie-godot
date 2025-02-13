extends State
class_name TimedState

@export_range(0, 100, 1) var min_time: int
@export_range(0, 100, 1) var max_time: int

@export_node_path("Range") var state_progress_indicator: NodePath = NodePath()
@onready var _state_progress_indicator_node: Range = get_node(state_progress_indicator)

@export_node_path("State") var next_state: NodePath = NodePath()
@onready var next_state_node: State = null if next_state.is_empty() else get_node(next_state)

var timer: SceneTreeTimer
var wait_time: float


func _ready() -> void:
	assert(min_time > 0, "min_time must be greater than 0.")
	assert(max_time > 0, "max_time must be greater than 0.")

	assert(!state_progress_indicator.is_empty(), "state_progress_indicator must not be empty.")
	assert(_state_progress_indicator_node != null, "state_progress_indicator node path is invalid.")


func enter(_msg: Dictionary = {}) -> void:
	super.enter(_msg)

	_state_progress_indicator_node.visible = true

	wait_time = min_time + randf() * (max_time - min_time)
	print("[%s] Waiting for %f (%f <= x <= %f) seconds." % [name, wait_time, min_time, max_time])
	timer = get_tree().create_timer(wait_time)

	_state_progress_indicator_node.max_value = wait_time

	await timer.timeout

	if next_state_node != null:
		state_machine.transition_to(next_state_node.name, {"wait_time": wait_time})


func update(delta: float) -> void:
	super.update(delta)

	_state_progress_indicator_node.value = timer.time_left


func exit() -> void:
	super.exit()

	_state_progress_indicator_node.visible = false
