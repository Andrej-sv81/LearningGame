extends CharacterBody2D

var can_laser: bool = true
var can_granade: bool = true
const SPEED := 500
signal laser(position, direction)
signal granade(position, direction)


func _process(_delta):
	var direction = Input.get_vector("left","right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("primary_action") and can_laser:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser: Marker2D = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserTimer.start()
		var laser_direction = (get_global_mouse_position() - position).normalized()
		laser.emit(selected_laser.global_position, laser_direction)
		
	if Input.is_action_just_pressed("secondary_action") and can_granade:
		can_granade = false
		$GranadeTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		var granade_direction = (get_global_mouse_position() - position).normalized()
		granade.emit(pos, granade_direction)

func _on_laser_timer_timeout():
	can_laser = true


func _on_granade_timer_timeout():
	can_granade  = true
