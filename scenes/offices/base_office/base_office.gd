extends Node2D

const grid_outline: PackedScene = preload("res://scenes/offices/base_office/grid_outline.tscn")

@onready var camera: GestureControlledCamera2D = $Camera


func _ready() -> void:
	# TODO: Dynamic row/column count based on office floor plan
	for i: int in range(0, 19):
		for j: int in range(0, 33):
			var cell: Node2D = grid_outline.instantiate()
			cell.position.x = i * GameInformation.GRID_SIZE
			cell.position.y = j * GameInformation.GRID_SIZE
			$Grid/Cells.add_child(cell)


func _on_room_selector_room_selected(room: Room) -> void:
	if GameInformation.money < room.price:
		return

	var base_room: BaseRoom = (room.scene.instantiate() as BaseRoom).init(room)
	var _connect_result: int = base_room.drag_state_changed.connect(_on_drag_state_changed)

	$Grid/Rooms.add_child(base_room)


func _on_drag_state_changed(dragging: bool) -> void:
	_toggle_camera_movement(dragging)
	($Grid/Cells as Node2D).visible = dragging


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
