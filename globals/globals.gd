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
		
var health = 50:
	set(value):
		health = min(value, 100)
		stat_change.emit()
