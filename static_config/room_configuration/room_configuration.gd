extends Node

const CONFIG_FILE_PATH: String = "res://static_config/room_configuration/room_configuration.cfg"

const ROOM_ACTIVE_IDENTIFIER: String = "active"
const ROOM_NAME_IDENTIFIER: String = "room_name"
const ROOM_PRICE_IDENTIFIER: String = "price"
const ROOM_INCOME_PER_DAY_DENTIFIER: String = "income_per_day"
const ROOM_ICON_IDENTIFIER: String = "icon"
const ROOM_SCENE_IDENTIFIER: String = "scene"

var available_rooms: Array[Room] = []


func _ready() -> void:
	var room_configuration: ConfigFile = ConfigFile.new()
	var error: Error = room_configuration.load(CONFIG_FILE_PATH)

	if error != OK:
		printerr("Unable to load configuration file located at %s" % CONFIG_FILE_PATH)
		print_stack()
		return

	for room: String in room_configuration.get_sections():
		var room_active: bool = room_configuration.get_value(room, ROOM_ACTIVE_IDENTIFIER)
		if !room_active:
			continue

		var room_name: String = room_configuration.get_value(room, ROOM_NAME_IDENTIFIER)
		var price: int = room_configuration.get_value(room, ROOM_PRICE_IDENTIFIER)
		var income_per_day: int = room_configuration.get_value(room, ROOM_INCOME_PER_DAY_DENTIFIER)
		var icon: String = room_configuration.get_value(room, ROOM_ICON_IDENTIFIER)
		var scene: String = room_configuration.get_value(room, ROOM_SCENE_IDENTIFIER)

		available_rooms.append(Room.new(room_name, price, income_per_day, icon, scene))
