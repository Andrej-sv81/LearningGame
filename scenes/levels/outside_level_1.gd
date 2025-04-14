extends ParentLevel

func _on_gate_on_player_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
