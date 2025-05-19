extends ItemContainer

func hit() -> void:
	if not opened:
		var tween = create_tween()
		tween.tween_property($TopSprite,"rotation", deg_to_rad(130), 0.15)
		tween.parallel().tween_property($TopSprite, "position", Vector2(55, -43), 0.15)
		$PointLight2D.show()
		var pos = $SpawnPositions/Marker2D.global_position
		open.emit(pos, current_direction)
		opened = true
		$AudioStreamPlayer2D.play()
