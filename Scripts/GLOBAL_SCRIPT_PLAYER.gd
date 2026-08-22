extends Node

var selected_player: String

var currHealth
var currMana

const maxHealth = 10
const maxMana = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currHealth = maxHealth
	currMana = maxMana
	selected_player = "cantrip"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func playerHurt():
	currHealth -= 1
	
func reset():
	currHealth = maxHealth
	currMana = maxMana
	selected_player = "cantrip"
