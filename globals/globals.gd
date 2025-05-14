extends Node

signal stat_change

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
var health = 50:
	set(value):
		if can_be_hit:
			can_be_hit = false
			health = min(value, 100)
			player_can_be_hit_timer()
			stat_change.emit()

func player_can_be_hit_timer():
	pass
var player_pos: Vector2
