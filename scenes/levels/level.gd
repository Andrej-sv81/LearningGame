extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")

func _ready():
	pass

func _on_gate_on_player_entered(body):
	print(body)


func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.direction = direction
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	$Projectiles.add_child(laser)

func _on_player_granade(pos, direction):
	var granade = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = direction * granade.speed
	$Projectiles.add_child(granade)
	
