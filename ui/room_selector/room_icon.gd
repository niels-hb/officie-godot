extends VBoxContainer
class_name RoomIcon

var room: Room

signal selected(room: Room)


func init(_room: Room) -> RoomIcon:
	self.room = _room

	return self


func _ready() -> void:
	($Icon as TextureRect).texture = load(room.icon)
	($Name as Label).text = room.name
	($Price as Label).text = "$%d" % room.price


func _on_pressed(event: InputEvent) -> void:
	if event is InputEventScreenTouch and (event as InputEventScreenTouch).pressed:
		selected.emit(room)
