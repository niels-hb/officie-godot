extends BaseRoom
class_name StaffRoom

@export var staff_preset_scene: PackedScene

@export_range(0, 100, 1) var maintenance_per_day: int

@onready var staff: Node = $Staff


func _ready() -> void:
	super._ready()

	assert(maintenance_per_day > 0, "maintenance_per_day must be greater than 0.")
