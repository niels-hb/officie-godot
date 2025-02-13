extends BaseRoom
class_name ActiveBaseRoom

@export_range(0, 100, 1) var income_per_day: int


func _ready() -> void:
	super._ready()

	assert(income_per_day > 0, "income_per_day must be greater than 0.")
