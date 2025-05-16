extends CharacterBody2D
class_name PlayerClass

var can_laser: bool = true
var can_grenade: bool = true

signal laser(position, direction)
signal grenade(position, direction)

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var alive: bool = true
@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	var direction = Input.get_vector("left","right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("primary_action") and can_laser and Globals.laser_amount > 0:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser: Marker2D = laser_markers[randi() % laser_markers.size()]
		var laser_direction = (get_global_mouse_position() - position).normalized()
		can_laser = false
		Globals.laser_amount -= 1
		laser.emit(selected_laser.global_position, laser_direction)
		$LaserTimer.start()
		$LaserParticles.emitting = true
		animation_player.play("charge_laser")
		
	if Input.is_action_just_pressed("secondary_action") and can_grenade and Globals.grenade_amount > 0:
		var pos = $LaserStartPositions.get_children()[0].global_position
		var grenade_direction = (get_global_mouse_position() - position).normalized()
		can_grenade = false
		Globals.grenade_amount -= 1
		grenade.emit(pos, grenade_direction)
		$GrenadeTimer.start()
		animation_player.play("charge_grenade")

func hit() -> void:
	Globals.health -= 10
	if Globals.health <= 0:
		alive = false
	
func _on_laser_timer_timeout():
	can_laser = true
	for light: PointLight2D in $GunLights.get_children():
		light.visible = true;

func _on_grenade_timer_timeout():
	can_grenade = true
