extends VBoxContainer
class_name RoomIcon

var room: Room


func init(_room: Room) -> RoomIcon:
	self.room = _room

	return self


func _ready() -> void:
	($Icon as TextureRect).texture = load(room.icon)
	($Name as Label).text = room.name
	($BuyButton as Button).text = "$%d" % room.price
