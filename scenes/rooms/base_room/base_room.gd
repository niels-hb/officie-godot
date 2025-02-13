extends Area2D
class_name BaseRoom

signal drag_state_changed(dragging: bool)

@onready var collison_shape: CollisionShape2D = $CollisionShape2D
@onready var image: Sprite2D = $Image
@onready var state_machine: StateMachine = $StateMachine
@onready var room_animation_player: AnimationPlayer = $RoomAnimationPlayer

var office: BaseOffice
var room: Room

var grid_start_position: Vector2i:
	get:
		return office.tile_map.local_to_map(
			position - (collison_shape.shape as RectangleShape2D).size / 2
		)

var grid_end_position: Vector2i:
	get:
		return grid_start_position + grid_size - Vector2i(1, 1)

var grid_size: Vector2i:
	get:
		return (collison_shape.shape as RectangleShape2D).size / GameInformation.GRID_SIZE


func init(_office: BaseOffice, _room: Room) -> BaseRoom:
	self.office = _office
	self.room = _room

	return self


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if state_machine.state != $StateMachine/Inactive:
		return

	if event is InputEventScreenTouch:
		_on_drag_state_changed((event as InputEventScreenTouch).pressed)
	elif event is InputEventScreenDrag:
		_on_dragging()


func _on_drag_state_changed(dragging: bool) -> void:
	var scale_while_dragging: float = 4.0 if dragging else 1.0
	collison_shape.scale = Vector2(scale_while_dragging, scale_while_dragging)

	drag_state_changed.emit(dragging)


func _on_dragging() -> void:
	var global_mouse_position: Vector2 = get_global_mouse_position()
	var snap_to_grid_offset: Vector2 = Vector2(
		int(global_mouse_position.x) % GameInformation.GRID_SIZE,
		int(global_mouse_position.y) % GameInformation.GRID_SIZE
	)

	global_position = global_mouse_position - snap_to_grid_offset


func _validate_position() -> bool:
	if office.draw_debug_cells:
		print("Grid Position: %s - %s" % [grid_start_position, grid_end_position])
		print("Grid Size: %s" % grid_size)

	return (
		office.is_floor_covering_area(grid_start_position, grid_size)
		and !office.is_blocking_tile_within_area(grid_start_position, grid_size)
		and !office.is_room_overlapping_existing_room(self)
	)
