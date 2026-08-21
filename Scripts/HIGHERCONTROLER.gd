extends Node

var masterVol:float
var musicVol:float
var sfxVol:float



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	masterVol = AudioServer.get_bus_volume_linear(0)
	musicVol = AudioServer.get_bus_volume_linear(1)
	sfxVol = AudioServer.get_bus_volume_linear(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			AudioServer.set_bus_mute(0, true) # 0 = master bus, probably
		NOTIFICATION_APPLICATION_FOCUS_IN:
			AudioServer.set_bus_mute(0, false)
			
			
func setMasterVol(val:float):
	AudioServer.set_bus_volume_linear(0, val)
	masterVol = val
	
func setMusicVol(val:float):
	AudioServer.set_bus_volume_linear(1, val)
	musicVol = val
	
func setSfxVol(val:float):
	AudioServer.set_bus_volume_linear(2, val)
	sfxVol = val

func pauseGame():
	get_tree().paused = true

func playGame():
	get_tree().paused = false
