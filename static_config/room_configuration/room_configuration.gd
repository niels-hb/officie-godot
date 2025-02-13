extends Node

const CONFIG_FILE_PATH: String = "res://static_config/room_configuration/room_configuration.cfg"

const ROOM_ACTIVE_IDENTIFIER: String = "active"
const ROOM_NAME_IDENTIFIER: String = "room_name"
const ROOM_SIZE_IDENTIFIER: String = "size"
const ROOM_PRICE_IDENTIFIER: String = "price"
const ROOM_INCOME_PER_DAY_DENTIFIER: String = "income_per_day"
const ROOM_TIME_UNTIL_OCCUPIED_DENTIFIER: String = "time_until_occupied"
const ROOM_TIME_UNTIL_COLLECTABLE_DENTIFIER: String = "time_until_collectable"
const ROOM_ICON_IDENTIFIER: String = "icon"
const ROOM_SCENE_IDENTIFIER: String = "scene"

var available_rooms: Array = []


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
		var room_size: Vector2i = room_configuration.get_value(room, ROOM_SIZE_IDENTIFIER)
		var price: int = room_configuration.get_value(room, ROOM_PRICE_IDENTIFIER)
		var income_per_day: int = room_configuration.get_value(room, ROOM_INCOME_PER_DAY_DENTIFIER)
		var time_until_occupied: Vector2i = room_configuration.get_value(
			room, ROOM_TIME_UNTIL_OCCUPIED_DENTIFIER
		)
		var time_until_collectable: Vector2i = room_configuration.get_value(
			room, ROOM_TIME_UNTIL_COLLECTABLE_DENTIFIER
		)
		var icon: String = room_configuration.get_value(room, ROOM_ICON_IDENTIFIER)
		var scene: String = room_configuration.get_value(room, ROOM_SCENE_IDENTIFIER)

		available_rooms.append(
			Room.new(
				room_name,
				room_size,
				price,
				income_per_day,
				time_until_occupied,
				time_until_collectable,
				icon,
				scene
			)
		)
