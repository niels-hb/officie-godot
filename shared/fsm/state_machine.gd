extends Node
class_name StateMachine

signal transitioned(state_name: String)

@export_node_path("State") var initial_state: NodePath
@onready var state: State = get_node(initial_state)


func _ready() -> void:
	await owner.ready

	for child: State in get_children():
		child.state_machine = self

	state.enter()


func _process(delta: float) -> void:
	state.update(delta)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	assert(has_node(target_state_name))

	print("[%s] %s -> %s" % [owner, state, target_state_name])

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	transitioned.emit(state.name)
