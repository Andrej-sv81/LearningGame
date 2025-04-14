extends RigidBody2D

@export var speed: int = 500


func  explode():
	$AnimationPlayer.play("explosion")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit();
