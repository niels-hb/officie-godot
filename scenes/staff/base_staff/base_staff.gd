extends CharacterBody2D

var movement_speed: float = 200.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var ready_to_navigate: bool = false


func _ready() -> void:
	call_deferred("_actor_setup")


func _actor_setup() -> void:
	await get_tree().physics_frame
	ready_to_navigate = true


func _physics_process(_delta: float) -> void:
	if ready_to_navigate:
		navigation_agent.target_position = get_global_mouse_position()

	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed

	var _result: bool = move_and_slide()
