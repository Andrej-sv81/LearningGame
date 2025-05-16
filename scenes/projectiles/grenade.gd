extends RigidBody2D

@export var speed: int = 500
var explosion_active: bool = false
var explosion_radius: int = 400

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func  explode():
	animation_player.play("explosion")
	explosion_active = true

func _process(_delta: float) -> void:
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			if target.global_position.distance_to(global_position) < explosion_radius:
				if "hit" in target and "alive" in target:
					if target.alive:
						target.hit()
