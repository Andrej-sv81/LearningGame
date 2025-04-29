extends ParentLevel


func _on_gate_on_player_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside_level_1.tscn")
	
func _change_scene() -> void:
	var inside: PackedScene = load("res://scenes/levels/inside_level_1.tscn")
	get_tree().change_scene_to_packed(inside)
