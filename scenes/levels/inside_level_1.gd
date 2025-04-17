extends ParentLevel

func _on_area_2d_body_entered(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	call_deferred("_change_scene")
	
func _change_scene() -> void:
	var outside: PackedScene = load("res://scenes/levels/outside_level_1.tscn")
	get_tree().change_scene_to_packed(outside)
