extends Area2D

var rotation_speed: int = 4
var options = ['laser','laser','laser', 'grenade', 'health']
var type = options[randi()%len(options)]

func _ready() -> void:
	if type == 'laser':
		$Sprite2D.modulate = Color(0.1, 0.3, 0.8);
	elif type == 'grenade':
		$Sprite2D.modulate = Color(0.8, 0.2, 0.1);
	else:
		$Sprite2D.modulate = Color(0.1, 0.8, 0.1);

func _process(delta: float) -> void:
	rotation += rotation_speed * delta
	
func _on_body_entered(_body: Node2D) -> void:
	if type == 'health':
		Globals.health += 20
	elif type == 'laser':
		Globals.laser_amount += 10
	elif type == 'grenade':
		Globals.grenade_amount += 1
	queue_free()
