extends Area2D
class_name BaseRoom

signal drag_state_changed(dragging: bool)

@onready var collisonShape: CollisionShape2D = $CollisionShape2D

var room: Room

var bought: bool = false:
	set(value):
		bought = value
		($BuyControls as Node2D).visible = !value


func init(_room: Room) -> BaseRoom:
	self.room = _room

	return self


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if bought:
		return

	if event is InputEventScreenTouch:
		_on_drag_state_changed((event as InputEventScreenTouch).pressed)
	elif event is InputEventScreenDrag:
		_on_dragging()


func _on_ok_button_pressed() -> void:
	if GameInformation.money < room.price:
		return

	GameInformation.money -= room.price

	bought = true


func _on_cancel_button_pressed() -> void:
	queue_free()


func _on_drag_state_changed(dragging: bool) -> void:
	var scale_while_dragging: float = 4.0 if dragging else 1.0
	collisonShape.scale = Vector2(scale_while_dragging, scale_while_dragging)

	drag_state_changed.emit(dragging)


func _on_dragging() -> void:
	var _global_mouse_position: Vector2 = get_global_mouse_position()
	var _base_offset: float = GameInformation.GRID_SIZE / 2.0
	var _grid_offset: Vector2 = Vector2(
		(int(_global_mouse_position.x) % GameInformation.GRID_SIZE) - _base_offset,
		(int(_global_mouse_position.y) % GameInformation.GRID_SIZE) - _base_offset
	)

	global_position = _global_mouse_position - _grid_offset
