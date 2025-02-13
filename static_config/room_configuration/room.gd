class_name Room

var name: String
var price: int
var icon: String
var scene: String


func _init(_name: String, _price: int, _icon: String, _scene: String) -> void:
	self.name = _name
	self.price = _price
	self.icon = _icon
	self.scene = _scene


func _to_string() -> String:
	return "%s ($%s) [%s; %s]" % [name, price, icon, scene]
