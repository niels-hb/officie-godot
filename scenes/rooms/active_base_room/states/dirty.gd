extends State
class_name Dirty

@export_range(0, 100, 1) var cleaning_time: int


func _ready() -> void:
	assert(cleaning_time > 0, "cleaning_time must be greater than 0.")


func _on_body_entered(body: Node2D) -> void:
	if (body as BaseStaff).assigned_room == owner:
		print("%s entered. Cleaning for %d seconds." % [body, cleaning_time])

		var timer: SceneTreeTimer = get_tree().create_timer(cleaning_time)
		await timer.timeout

		(body as BaseStaff).assigned_room = null
		state_machine.transition_to("Ready")
