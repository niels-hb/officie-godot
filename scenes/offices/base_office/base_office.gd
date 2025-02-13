extends Node2D
class_name BaseOffice

@onready var camera: GestureControlledCamera2D = $Camera
@onready var tile_map: TileMap = $Grid/TileMap


func _on_room_selector_room_selected(room: Room) -> void:
	if GameInformation.money < room.price:
		return

	var base_room: BaseRoom = (room.scene.instantiate() as BaseRoom).init(self, room)
	base_room.position = Vector2i(10, 20) * GameInformation.GRID_SIZE
	var _connect_result: int = base_room.drag_state_changed.connect(_on_drag_state_changed)

	$Grid/Rooms.add_child(base_room)


func _on_drag_state_changed(dragging: bool) -> void:
	_toggle_camera_movement(dragging)


func _toggle_camera_movement(disabled: bool) -> void:
	camera.movement_gesture = (
		GestureControlledCamera2D.MOVEMENT_GESTURE.DISABLED
		if disabled
		else GestureControlledCamera2D.MOVEMENT_GESTURE.SINGLE_DRAG
	)
	camera.zoom_gesture = (
		GestureControlledCamera2D.ZOOM_GESTURE.DISABLED
		if disabled
		else GestureControlledCamera2D.ZOOM_GESTURE.PINCH
	)
