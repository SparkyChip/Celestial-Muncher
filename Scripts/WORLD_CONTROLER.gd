extends Node2D

@onready var path = "res://Music/combat.mp3"

# These variables signify the "Dependancies" each level is required to
# have.
@onready var cantripPlayer = $"../C_PlayerBody"
@onready var audio = $"../GameMusic"
@onready var m_animator = $"../MusicSwitches/MusicAnimator"
@onready var brutusPlayer: CharacterBody2D = $"../B_PlayerBody"


var currPlayer: CharacterBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalScriptPlayer.selected_player == "brutus":
		cantripPlayer.queue_free()
		currPlayer = brutusPlayer
		
	elif GlobalScriptPlayer.selected_player == "cantrip":
		brutusPlayer.queue_free()
		currPlayer = cantripPlayer
	elif GlobalScriptPlayer.selected_player == "placeholder02":
		brutusPlayer.queue_free()
		currPlayer = cantripPlayer
	elif GlobalScriptPlayer.selected_player == "placeholder03":
		brutusPlayer.queue_free()
		currPlayer = cantripPlayer
	#print(audio)
	GlobalScriptPlayer.reset()
	Highercontroler.playGame()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
		
	if GlobalScriptPlayer.selected_player == "placeholder02":
		cantripPlayer.modulate = Color(3,1,1,1)
	elif GlobalScriptPlayer.selected_player == "placeholder03":
		cantripPlayer.modulate = Color(1,1,3,1)	
		
	if currPlayer.getIsDied():
		get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
		



func _on_music_switch_creepy_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		audio.stream = load("res://Music/shiver me timbers.mp3")
		audio.play()

func _on_music_switch_boss_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		audio.stream = load("res://Music/BossMusic.mp3")
		audio.play()
func _on_death_screen_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		audio.stream = load("res://Music/DeathScreen.mp3") # Replace with function body.
		audio.play()

func _on_music_switch_combat_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		audio.stream = load(path) # Replace with function body.
		audio.play()


func _on_music_slower_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		m_animator.play("SlowDown")


func _on_music_slower_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		m_animator.play("SpeedUp")


func _on_pause_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		audio.stop()
