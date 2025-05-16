extends CharacterBody2D

var can_be_hit: bool = true
var direction: Vector2

@onready var drone_animation: AnimationPlayer = $DroneAnimation

@export var health: int = 20
@export var speed: int = 700
@export var active: bool = false
@export var alive: bool = true

func _ready() -> void:
	$Explosion.hide()
	$Drone.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		look_at(Globals.player_pos)
		direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		var collision := move_and_collide(velocity * delta)
		if collision:
			drone_animation.play("explosion")

func hit():
	if can_be_hit:
		can_be_hit = false
		health -= 10
		$HitTimer.start()
		drone_animation.play("flash")
	if health <= 0:
		alive = false
		can_be_hit = false
		drone_animation.play("explosion")

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true

func _on_hit_timer_timeout() -> void:
	can_be_hit = true
