extends CanvasLayer

var room_icon: PackedScene = preload("res://ui/room_selector/room_icon.tscn")


func _ready() -> void:
	for room: Room in RoomConfiguration.available_rooms:
		var _room_icon: RoomIcon = (room_icon.instantiate() as RoomIcon).init(room)
		$Background/ScrollContainer/MarginContainer/AvailableRooms.add_child(_room_icon)
