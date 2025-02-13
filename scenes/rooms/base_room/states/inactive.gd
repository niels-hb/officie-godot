extends State


func enter(_msg: Dictionary = {}) -> void:
	super.enter()

	(owner as BaseRoom).room_animation_player.play("fade_in_inactive_room")
	await (owner as BaseRoom).room_animation_player.animation_finished
	(owner as BaseRoom).room_animation_player.play("pulse_inactive_room")


func exit() -> void:
	super.exit()

	(owner as BaseRoom).room_animation_player.stop()
