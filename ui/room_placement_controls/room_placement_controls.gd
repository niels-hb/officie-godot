extends CanvasLayer
class_name RoomPlacementControls

signal confirm
signal cancel


func set_confirm_button(disabled: bool) -> void:
	($HBoxContainer/OkMarginContainer/OkButton as TextureButton).disabled = disabled


func _on_ok_button_pressed() -> void:
	confirm.emit()


func _on_cancel_button_pressed() -> void:
	cancel.emit()
