extends InteractiveState

var income: int


func enter(_msg: Dictionary = {}) -> void:
	super.enter(_msg)

	assert(_msg.has("wait_time"), "wait_time must be passed from previous state.")
	assert(_msg.wait_time is float, "wait_time must be of type float.")

	@warning_ignore("unsafe_cast")
	var occupation_time: float = roundi(_msg.wait_time as float)
	var occupation_time_in_days: int = roundi(occupation_time / GameInformation.SECONDS_PER_DAY)
	income = (owner as ActiveBaseRoom).income_per_day * occupation_time_in_days


func on_interaction() -> void:
	GameInformation.money += income

	state_machine.transition_to("Dirty")
