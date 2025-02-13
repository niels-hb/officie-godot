extends CanvasLayer


func _process(_delta: float) -> void:
	($Background/MarginContainer/HBoxContainer/Money/Value as Label).text = (
		"$%d" % GameInformation.money
	)
