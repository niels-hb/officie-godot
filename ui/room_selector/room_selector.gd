extends CanvasLayer
class_name RoomSelector

signal room_selected(room: BaseRoom)

signal closed


func _on_room_selected(room: BaseRoom) -> void:
	room_selected.emit(room)


func _on_close_button_pressed() -> void:
	closed.emit()
