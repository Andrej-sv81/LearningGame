extends StaticBody2D

signal on_player_entered(body)


func _on_area_2d_body_entered(body):
	on_player_entered.emit(body)
