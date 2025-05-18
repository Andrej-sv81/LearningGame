extends CharacterBody2D
var can_be_hit: bool = true
var active: bool = false
var alive: bool = true
var speed: int = 200
var health: int = 200

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var hunter_animation: AnimationPlayer = $HunterAnimation

func _ready() -> void:
	navigation_agent_2d.target_position = Globals.player_pos
	
func _physics_process(_delta: float) -> void:
	if active:
		var next_path_pos: Vector2 = navigation_agent_2d.get_next_path_position()
		look_at(next_path_pos)
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	
func hit() -> void:
	if can_be_hit:
		can_be_hit = false
		health -= 10
		$Timers/HitTimer.start()
		hunter_animation.play("flash")
	if health <= 0:
		alive = false
		queue_free()
		
func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true

func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false

func _on_navigation_timer_timeout() -> void:
	navigation_agent_2d.target_position = Globals.player_pos

func _on_hit_timer_timeout() -> void:
	can_be_hit = true
