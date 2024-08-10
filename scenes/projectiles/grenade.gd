extends RigidBody2D

@export var speed: int = 500


func  explode():
	$AnimationPlayer.play("explosion")
