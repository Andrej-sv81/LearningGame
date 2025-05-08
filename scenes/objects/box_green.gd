extends ItemContainer

func hit() -> void:
	$TopSprite.hide()
	var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
	open.emit(pos, current_direction)
