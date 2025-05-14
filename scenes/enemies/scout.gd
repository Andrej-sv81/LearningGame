extends CharacterBody2D

var player_near: bool = false
var can_laser: bool = true
var alt_gun: bool = true
var can_be_hit: bool = true

@export var health: int = 50

signal laser(pos, direction)

func _process(_delta: float) -> void:
	if player_near:
		look_at(Globals.player_pos)
		if can_laser:
			var marker = $LaserSpawnPositions.get_child(alt_gun) as Marker2D
			alt_gun = not alt_gun
			var pos: Vector2 = marker.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserCooldown.start()

func hit() -> void:
	if can_be_hit:
		can_be_hit = false
		health -= 10
		$Timers/HitTimer.start()
	if health <= 0:
		queue_free()
	
func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_near = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_near = false

func _on_laser_cooldown_timeout() -> void:
	can_laser = true

func _on_hit_timer_timeout() -> void:
	can_be_hit = true
