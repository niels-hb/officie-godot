extends TimedState
class_name SpriteTimedState

@export var texture_on_enter: Texture
@export var texture_on_exit: Texture

@export_node_path("Sprite2D") var sprite: NodePath = NodePath()
@onready var sprite_node: Sprite2D = get_node(sprite)


func _ready() -> void:
	super._ready()

	assert(texture_on_enter != null, "texture_on_enter must not be null.")

	assert(!sprite.is_empty(), "sprite must not be empty.")
	assert(sprite_node != null, "sprite node path is invalid.")


func enter(_msg: Dictionary = {}) -> void:
	sprite_node.texture = texture_on_enter

	await super.enter(_msg)


func exit() -> void:
	if texture_on_exit != null:
		sprite_node.texture = texture_on_exit

	super.exit()
