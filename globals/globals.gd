extends Node

signal stat_change

var player_hit_sound: AudioStreamPlayer2D

func _ready() -> void:
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)
	
var laser_amount = 100:
	get: #can be removed and it will still work
		return laser_amount
	set(value):
		laser_amount = min(value, 100)
		stat_change.emit()
		
var grenade_amount = 10:
	set(value):
		grenade_amount = min(value, 10)
		stat_change.emit()
		
var can_be_hit: bool = true
var health = 100:
	set(value):
		if value < health:
			if can_be_hit:
				can_be_hit = false
				health = max(value, 0)
				player_can_be_hit_timer()
				player_hit_sound.play()
		else:
			health = min(value,100)
		stat_change.emit()

func player_can_be_hit_timer():
	await get_tree().create_timer(0.5).timeout
	can_be_hit = true
	
var player_pos: Vector2
