extends State
class_name InteractiveState

@export_node_path("BaseButton") var interactable: NodePath = NodePath()
@onready var interactable_node: BaseButton = get_node(interactable)


func _ready() -> void:
	assert(!interactable.is_empty(), "interactable must not be empty.")
	assert(interactable_node != null, "interactable node path is invalid.")

	var _connect_result: int = interactable_node.pressed.connect(on_interaction)


func enter(_msg: Dictionary = {}) -> void:
	super.enter(_msg)

	interactable_node.visible = true


func exit() -> void:
	super.exit()

	interactable_node.visible = false


func on_interaction() -> void:
	pass
