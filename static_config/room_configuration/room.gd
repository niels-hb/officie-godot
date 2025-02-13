class_name Room

var name: String
var size: Vector2i
var price: int
var income_per_day: int
var time_to_build: Vector2i
var time_until_occupied: Vector2i
var time_until_collectable: Vector2i
var time_until_cleaned: Vector2i
var icon: String
var scene: PackedScene


func _init(
	_name: String, _size: Vector2i, _price: int, _income_per_day: int, _icon: String, _scene: String
) -> void:
	self.name = _name
	self.size = _size
	self.price = _price
	self.income_per_day = _income_per_day
	self.icon = _icon
	self.scene = load(_scene)


func _to_string() -> String:
	return "%s ($%s) [%s; %s]" % [name, price, icon, scene]
