extends Node2D

@onready var path = "res://Music/combat.mp3"

# These variables signify the "Dependancies" each level is required to
# have.
@onready var player = $"../C_PlayerBody"
@onready var cursor_tracker = $"../CursorTracker"
@onready var audio = $"../GameMusic"
@onready var m_animator = $"../MusicSwitches/MusicAnimator"





var isCharged = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(audio)
	GlobalScriptPlayer.reset()
	Highercontroler.playGame()
	
	cursor_tracker.global_position = player.global_position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (cursor_tracker.global_position.distance_to(player.global_position) > cursor_tracker.getRange()):
		cursor_tracker.global_position = player.global_position
		
		
	
	
	if Input.is_action_pressed("click(left)") and isCharged == false:
		player.addCurrStr(delta * 10)
		player.setModulate(player.getCurrStr())
	else:
		player.resetCurrStr()
		player.setModulate(player.getCurrStr())
		
	if player.getCurrStr() >= player.getMaxStr():
		fastFire()
		
		
	if (GlobalScriptPlayer.currHealth == 0):
		get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
		
func fastFire():
	isCharged = true
	
	for i in range(player.getFastProjNum()):
		var instance = firePew()
		await get_tree().create_timer(player.getFastCooldown()).timeout
	await get_tree().create_timer(2.0).timeout
	isCharged = false
		
	
# Called when the node enters the scene tree for the first time.


var is_cooldown_s01 = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed:
			#print("click!!")
			fireMagicBomb()
			
		elif event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed and !is_cooldown_s01:
			firePew()
		
		
		
func firePew():
	#print(get_global_mouse_position())
	var spell_instance = player.getSpell(0).instantiate()
	#print(spell_instance)
	spell_instance.global_position = cursor_tracker.global_position
	#print(spell_instance.global_position)
	pew(spell_instance)
	return spell_instance
	
func pew(instance):
	add_child(instance)
	instance.setOGPos(player)
	instance.setRotation(calc_pew_dir(), player.getAccuracy())
	set_pew_cooldown(instance)
	await get_tree().create_timer(player.getLifeTime()).timeout
	await instance.explode()
	
	remove_child(instance)
	
func calc_pew_dir() -> Vector2:
	var mouse_pos = get_global_mouse_position()
	
	var grad_x = (mouse_pos.x - player.global_position.x) 
	var grad_y = mouse_pos.y - player.global_position.y
	
	var move_dir = Vector2(grad_x, grad_y)
	
	return move_dir.normalized()

func set_pew_cooldown(instance):
	is_cooldown_s01 = true
	await get_tree().create_timer(player.getCooldown()).timeout
	is_cooldown_s01 = false
		
		
		
func fireMagicBomb():
	var spell_instance = player.getSpell(1).instantiate()
	if player.getCurrBombs() < player.getMaxBombs():
		#print(spell_instance)
		spell_instance.global_position = cursor_tracker.global_position
		#print(spell_instance.global_position)
		
		
		
		spell01Fire(spell_instance)
		player.addCurrBombs()
		spell_instance.playSound()
		
func spell01Fire(instance):
	
	add_child(instance)
	
	await get_tree().create_timer(instance.getLifeTime()).timeout
	instance.playDeath()
	
	remove_child(instance)
	player.decCurrBombs()
			


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
