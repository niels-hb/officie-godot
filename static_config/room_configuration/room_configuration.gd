extends Node

const _CONFIG_FILE_PATH: String = "res://static_config/room_configuration/room_configuration.cfg"

const _ROOM_ACTIVE_IDENTIFIER: String = "active"
const _ROOM_NAME_IDENTIFIER: String = "room_name"
const _ROOM_SIZE_IDENTIFIER: String = "size"
const _ROOM_PRICE_IDENTIFIER: String = "price"
const _ROOM_ICON_IDENTIFIER: String = "icon"
const _ROOM_SCENE_IDENTIFIER: String = "scene"

var available_rooms: Array = []


func _ready() -> void:
	var room_configuration: ConfigFile = ConfigFile.new()
	var error: Error = room_configuration.load(_CONFIG_FILE_PATH)

	if error != OK:
		printerr("Unable to load configuration file located at %s" % _CONFIG_FILE_PATH)
		print_stack()
		return

	for room: String in room_configuration.get_sections():
		var room_active: bool = room_configuration.get_value(room, _ROOM_ACTIVE_IDENTIFIER)
		var room_name: String = room_configuration.get_value(room, _ROOM_NAME_IDENTIFIER)
		var room_size: Vector2i = room_configuration.get_value(room, _ROOM_SIZE_IDENTIFIER)
		var price: int = room_configuration.get_value(room, _ROOM_PRICE_IDENTIFIER)
		var icon: String = room_configuration.get_value(room, _ROOM_ICON_IDENTIFIER)
		var scene: String = room_configuration.get_value(room, _ROOM_SCENE_IDENTIFIER)

		available_rooms.append(Room.new(room_active, room_name, room_size, price, icon, scene))
