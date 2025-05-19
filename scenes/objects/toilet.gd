extends ItemContainer

func hit() -> void:
	if not opened:
		$TopSprite.hide()
		var pos = $SpawnPositions/Marker2D.global_position
		open.emit(pos, current_direction)
		opened = true
		$AudioStreamPlayer2D.play()
