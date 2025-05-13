extends CharacterBody2D

func _process(_delta: float) -> void:
	look_at(Globals.player_pos)
