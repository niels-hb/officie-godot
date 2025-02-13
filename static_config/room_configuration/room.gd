class_name Room

var name: String
var price: int
var income_per_day: int
var icon: String
var scene: PackedScene


func _init(_name: String, _price: int, _income_per_day: int, _icon: String, _scene: String) -> void:
	self.name = _name
	self.price = _price
	self.income_per_day = _income_per_day
	self.icon = _icon
	self.scene = load(_scene)


func _to_string() -> String:
	return "%s ($%s) [%s; %s]" % [name, price, icon, scene]
