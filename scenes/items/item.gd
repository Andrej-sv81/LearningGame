extends Area2D

var rotation_speed: int = 4
var options = ['laser','laser','laser', 'grenade', 'health']
var type = options[randi()%len(options)]
var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready() -> void:
	if type == 'laser':
		$PowerSprite.modulate = Color(0.1, 0.3, 0.8);
	elif type == 'grenade':
		$PowerSprite.modulate = Color(0.8, 0.2, 0.1);
	else:
		$PowerSprite.modulate = Color(0.1, 0.8, 0.1);

	var target_position = position + direction * distance
	var tween = create_tween()
	#tween.set_parallel(true) moze i ovako za sve sledece tweenove
	tween.tween_property(self, "position", target_position, 0.5)
	tween.parallel().tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0,0))
	
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

func _on_timer_timeout() -> void:
	queue_free()
