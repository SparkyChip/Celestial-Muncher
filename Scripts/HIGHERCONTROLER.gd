extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			AudioServer.set_bus_mute(0, true) # 0 = master bus, probably
		NOTIFICATION_APPLICATION_FOCUS_IN:
			AudioServer.set_bus_mute(0, false)
