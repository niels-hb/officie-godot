extends CanvasLayer

var room_icon_scene: PackedScene = preload("res://ui/room_selector/room_icon.tscn")

signal room_selected(room: Room)


func _ready() -> void:
	for room: Room in RoomConfiguration.available_rooms:
		var room_icon: RoomIcon = (room_icon_scene.instantiate() as RoomIcon).init(room)
		var _connect_result: int = room_icon.selected.connect(_on_room_selected)
		$Background/ScrollContainer/MarginContainer/AvailableRooms.add_child(room_icon)


func _on_room_selected(room: Room) -> void:
	room_selected.emit(room)
