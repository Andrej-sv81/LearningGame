extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laser(position, direction)
signal grenade(position, direction)

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	var direction = Input.get_vector("left","right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("primary_action") and can_laser:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser: Marker2D = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserTimer.start()
		var laser_direction = (get_global_mouse_position() - position).normalized()
		laser.emit(selected_laser.global_position, laser_direction)
		$LaserParticles.emitting = true
		
	if Input.is_action_just_pressed("secondary_action") and can_grenade:
		can_grenade = false
		$GrenadeTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		var grenade_direction = (get_global_mouse_position() - position).normalized()
		grenade.emit(pos, grenade_direction)

func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
