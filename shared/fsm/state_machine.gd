extends Node
class_name StateMachine

signal transitioned(state_name: String)

@export_node_path("State") var initial_state: NodePath = NodePath()
@onready var state: State = get_node(initial_state)


func _ready() -> void:
	assert(!initial_state.is_empty(), "initial_state must not be empty.")
	assert(state != null, "initial_state node path is invalid.")

	call_deferred("_state_setup")


func _state_setup() -> void:
	for child: State in get_children():
		child.state_machine = self

	state.enter()


func _process(delta: float) -> void:
	state.update(delta)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	assert(has_node(target_state_name), "target_state_name does not exist.")

	print("[%s] %s -> %s" % [owner, state, target_state_name])

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	transitioned.emit(state.name)
