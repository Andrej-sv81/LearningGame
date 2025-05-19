extends CharacterBody2D

var can_be_hit: bool = true
var direction: Vector2

@onready var drone_animation: AnimationPlayer = $DroneAnimation

@export var health: int = 20
@export var max_speed: int = 700
var speed: int = 0
@export var active: bool = false
@export var alive: bool = true
var explosion_radius: int = 400
var explosion_active: bool = false

func _ready() -> void:
	$Explosion.hide()
	$Drone.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		look_at(Globals.player_pos)
		direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		var collision: KinematicCollision2D = move_and_collide(velocity * delta)
		if collision:
			drone_animation.play("explosion")
			explosion_active = true
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			if target.global_position.distance_to(global_position) < explosion_radius:
				if "hit" in target and "alive" in target:
					if target.alive:
						target.hit()
		
func hit():
	if can_be_hit:
		can_be_hit = false
		health -= 10
		$HitTimer.start()
		drone_animation.play("flash")
		$AudioStreamPlayer2D.play()
	if health <= 0:
		alive = false
		can_be_hit = false
		drone_animation.play("explosion")
		explosion_active = true

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	var speed_tween = create_tween()
	speed_tween.tween_property(self, "speed", max_speed, 5)

func _on_hit_timer_timeout() -> void:
	can_be_hit = true
