extends Node2D
class_name BaseOffice

@onready var camera: GestureControlledCamera2D = $Camera
@onready var tile_map: TileMap = $Grid/TileMap

const TILEMAP_FLOOR_LAYER: int = 0
const TILEMAP_WALL_LAYER: int = 1

const TILEMAP_CDL_BLOCKING: String = "blocking"


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


func is_blocking_tile_within_area(area_position: Vector2i, area_size: Vector2i) -> bool:
	return (
		(
			get_tiles_in_area([TILEMAP_FLOOR_LAYER, TILEMAP_WALL_LAYER], area_position, area_size)
			. filter(_filter_null_values)
			. map(func(tile: TileData) -> bool: return tile.get_custom_data(TILEMAP_CDL_BLOCKING))
			. find(true)
		)
		> -1
	)


func is_floor_covering_area(area_position: Vector2i, area_size: Vector2i) -> bool:
	return (
		len(
			get_tiles_in_area([TILEMAP_FLOOR_LAYER], area_position, area_size).filter(
				_filter_null_values
			)
		)
		== area_size.x * area_size.y
	)


func is_room_overlapping_existing_room(new_room: BaseRoom) -> bool:
	for existing_room: BaseRoom in ($Grid/Rooms as Node2D).get_children():
		if existing_room == new_room:
			continue

		assert(existing_room is BaseRoom)

		if _is_overlapping(
			existing_room.grid_start_position,
			existing_room.grid_start_position + existing_room.grid_size,
			new_room.grid_start_position,
			new_room.grid_start_position + new_room.grid_size,
		):
			return true

	return false


func get_tiles_in_area(layers: Array, area_position: Vector2i, area_size: Vector2i) -> Array:
	var tiles: Array = []

	for i: int in range(area_position.x, area_position.x + area_size.x):
		for j: int in range(area_position.y, area_position.y + area_size.y):
			for layer: int in layers:
				tiles.append(tile_map.get_cell_tile_data(layer, Vector2i(i, j)))

	return tiles


func _filter_null_values(value: Variant) -> bool:
	return value != null


func _is_overlapping(l1: Vector2, r1: Vector2, l2: Vector2, r2: Vector2) -> bool:
	return l1.x <= r2.x and r1.x >= l2.x and l1.y <= r2.y and r1.y >= l2.y
