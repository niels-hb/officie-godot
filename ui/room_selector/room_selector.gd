extends CanvasLayer
class_name RoomSelector

signal room_selected(room_scene: PackedScene)

signal closed


func _on_room_selected(room_scene: PackedScene) -> void:
	room_selected.emit(room_scene)


func _on_close_button_pressed() -> void:
	closed.emit()
