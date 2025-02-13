extends CanvasLayer
class_name RoomPlacementControls

signal confirm
signal cancel


func _on_ok_button_pressed() -> void:
	confirm.emit()


func _on_cancel_button_pressed() -> void:
	cancel.emit()
