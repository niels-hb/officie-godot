extends Node
class_name RoomDetails

@export var room_scene: PackedScene
@onready var room: BaseRoom = room_scene.instantiate()

@onready var room_icon: TextureRect = $HBoxContainer/Icon
@onready var room_name: Label = $HBoxContainer/VBoxContainer/Name
@onready var room_price: Label = $HBoxContainer/VBoxContainer/GeneralInformation/Price/Value

@onready var room_building: Label = $HBoxContainer/VBoxContainer/TimingInformation/Building/Value

@onready var room_income: VBoxContainer = $HBoxContainer/VBoxContainer/GeneralInformation/Income
@onready var room_income_value: Label = $HBoxContainer/VBoxContainer/GeneralInformation/Income/Value
@onready var room_waiting: VBoxContainer = $HBoxContainer/VBoxContainer/TimingInformation/Waiting
@onready var room_waiting_value: Label = $HBoxContainer/VBoxContainer/TimingInformation/Waiting/Value
@onready var room_occupied: VBoxContainer = $HBoxContainer/VBoxContainer/TimingInformation/Occupied
@onready
var room_occupied_value: Label = $HBoxContainer/VBoxContainer/TimingInformation/Occupied/Value
@onready var room_cleaning: VBoxContainer = $HBoxContainer/VBoxContainer/TimingInformation/Cleaning
@onready
var room_cleaning_value: Label = $HBoxContainer/VBoxContainer/TimingInformation/Cleaning/Value

@onready
var room_maintenance: VBoxContainer = $HBoxContainer/VBoxContainer/GeneralInformation/Maintenance
@onready
var room_maintenance_value: Label = $HBoxContainer/VBoxContainer/GeneralInformation/Maintenance/Value

signal selected(room: BaseRoom)


func _ready() -> void:
	assert(room != null, "room must not be null.")

	room_icon.texture = room.icon

	room_name.text = room.human_name
	room_price.text = "$%d" % room.price

	room_building.text = _format_timing(room.get_node("StateMachine/Building") as TimedState)

	if room is ActiveBaseRoom:
		room_income.visible = true
		room_waiting.visible = true
		room_occupied.visible = true
		room_cleaning.visible = true

		room_income_value.text = _format_recurring_expense((room as ActiveBaseRoom).income_per_day)

		room_waiting_value.text = _format_timing(room.get_node("StateMachine/Ready") as TimedState)
		room_occupied_value.text = _format_timing(
			room.get_node("StateMachine/Occupied") as TimedState
		)
		room_cleaning_value.text = (
			"%d days"
			% (
				roundf((room.get_node("StateMachine/Dirty") as Dirty).cleaning_time)
				/ GameInformation.SECONDS_PER_DAY
			)
		)

	if room is StaffRoom:
		room_maintenance.visible = true

		room_maintenance_value.text = _format_recurring_expense(
			(room as StaffRoom).maintenance_per_day
		)


func _on_buy_button_pressed() -> void:
	selected.emit(room)


func _format_recurring_expense(expense: int) -> String:
	return "$%d/day" % expense


func _format_timing(timed_state: TimedState) -> String:
	return (
		"%d-%d days"
		% [
			roundf(timed_state.min_time) / GameInformation.SECONDS_PER_DAY,
			roundf(timed_state.max_time) / GameInformation.SECONDS_PER_DAY
		]
	)
