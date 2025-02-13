extends State


func enter(_msg: Dictionary = {}) -> void:
	var staff: BaseStaff = (
		((owner as StaffRoom).staff_preset_scene.instantiate() as BaseStaff)
		. init(owner as StaffRoom)
	)

	(owner as StaffRoom).staff.add_child(staff)
