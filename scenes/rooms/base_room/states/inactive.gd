extends State


func enter(_msg: Dictionary = {}) -> void:
	super.enter()

	(owner as BaseRoom).buy_controls.visible = true


func exit() -> void:
	super.exit()

	(owner as BaseRoom).buy_controls.visible = false
