extends CanvasLayer
class_name BottomBar

signal store_selected


func _on_store_button_pressed() -> void:
	store_selected.emit()
