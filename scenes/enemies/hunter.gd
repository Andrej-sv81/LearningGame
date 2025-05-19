extends CharacterBody2D
var can_be_hit: bool = true
var active: bool = false
var alive: bool = true
var player_near: bool = false
var speed: int = 300
var health: int = 200

@onready var navigation_agent_2d: NavigationAgent2D = $Agent/NavigationAgent2D
@onready var hunter_animation: AnimationPlayer = $HunterAnimation
@onready var flash_animation: AnimationPlayer = $FlashAnimation

func _ready() -> void:
	navigation_agent_2d.target_position = Globals.player_pos
	navigation_agent_2d.path_desired_distance = 4.0
	navigation_agent_2d.target_desired_distance = 4.0
func _physics_process(_delta: float) -> void:
	if active:
		var next_path_pos: Vector2 = navigation_agent_2d.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		var look_angle = direction.angle()
		rotation = look_angle + deg_to_rad(90)
	
func hit() -> void:
	if can_be_hit:
		can_be_hit = false
		health -= 10
		$Timers/HitTimer.start()
		flash_animation.play("flash")
		$Node2D/HitParticles.emitting = true
		$AudioStreamPlayer2D.play()
	if health <= 0:
		alive = false
		queue_free()
		
func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	hunter_animation.play("walk")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false

func _on_navigation_timer_timeout() -> void:
	navigation_agent_2d.target_position = Globals.player_pos

func _on_hit_timer_timeout() -> void:
	can_be_hit = true

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_near = true
	hunter_animation.play("bite")
	
func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_near = false
	hunter_animation.play("walk")

#druga opcija je da na kraju bite animacije dodamo Bite method call
#ako da dodamo kada se celjusti sklopeu animaciji, HP ce biti oduzet u pracom trenutku
#func _on_hunter_animation_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "bite":
		#if player_near:
			#Globals.health -= 20
			#$Timers/AttackTimer.start()

func bite() -> void:
	if player_near:
		Globals.health -= 20
		$Timers/AttackTimer.start()
		
func _on_attack_timer_timeout() -> void:
	if player_near:
		hunter_animation.play("bite")
