extends CharacterBody2D

var player_near: bool = false
var can_laser: bool = true
var alt_gun: bool = true
var can_be_hit: bool = true
var active: bool = false

@export var alive: bool = true
@export var health: int = 50
@export var speed: int = 100

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var scout_animation: AnimationPlayer = $ScoutAnimation

signal laser(pos, direction)

func _ready() -> void:
	navigation_agent_2d.target_position = Globals.player_pos
	
func _process(_delta: float) -> void:
	if active:
		look_at(Globals.player_pos)
		var next_path_pos: Vector2 = navigation_agent_2d.get_next_path_position()
		var dir: Vector2 = (next_path_pos - global_position).normalized()
		velocity = dir * speed
		move_and_slide()
	if player_near:
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
		scout_animation.play("flash")
		$AudioStreamPlayer2D.play()
	if health <= 0:
		alive = false
		queue_free()
	
func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_near = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_near = false

func _on_laser_cooldown_timeout() -> void:
	can_laser = true

func _on_hit_timer_timeout() -> void:
	can_be_hit = true

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true

func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false

func _on_navigationt_timer_timeout() -> void:
	navigation_agent_2d.target_position = Globals.player_pos
