class_name Room

var name: String
var size: Vector2i
var price: int
var icon: String
var scene: PackedScene


func _init(_name: String, _size: Vector2i, _price: int, _icon: String, _scene: String) -> void:
	self.name = _name
	self.size = _size
	self.price = _price
	self.icon = _icon
	self.scene = load(_scene)


func _to_string() -> String:
	return "%s ($%s) [%s; %s]" % [name, price, icon, scene]
