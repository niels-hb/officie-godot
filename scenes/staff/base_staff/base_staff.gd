extends CharacterBody2D
class_name BaseStaff

@export_range(1, 500, 1) var movement_speed: float

@export var assignable_states: Array[String]

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var staff_room: StaffRoom

var assigned_room: BaseRoom

var ready_to_navigate: bool = false


func init(_staff_room: StaffRoom) -> BaseStaff:
	staff_room = _staff_room

	return self


func _ready() -> void:
	assert(!assignable_states.is_empty())
	assert(staff_room != null)
	assert(staff_room is StaffRoom)

	position = staff_room.position

	call_deferred("_actor_setup")


func _actor_setup() -> void:
	await get_tree().physics_frame
	ready_to_navigate = true


func _physics_process(_delta: float) -> void:
	assigned_room = _find_assignable_room()

	if ready_to_navigate:
		navigation_agent.target_position = (
			assigned_room.position if assigned_room != null else staff_room.position
		)

	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed

	var _result: bool = move_and_slide()


func _find_assignable_room() -> BaseRoom:
	if assigned_room != null:
		return assigned_room

	for room: BaseRoom in staff_room.office.rooms.get_children():
		if assignable_states.has(room.state_machine.state.name):
			return room

	return null
