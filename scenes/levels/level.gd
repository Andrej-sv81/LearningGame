extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _ready():
	pass

func _on_gate_on_player_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)


func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.direction = direction
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	$Projectiles.add_child(laser)

func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	


func _on_house_player_entered():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8,0.8), 1).set_trans(Tween.TRANS_ELASTIC)
	

func _on_house_player_exited():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 1).set_trans(Tween.TRANS_ELASTIC)
	

