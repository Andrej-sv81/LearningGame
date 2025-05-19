extends CharacterBody2D

var can_be_hit: bool = true
var player_near: bool = false
var active: bool = false

@onready var bug_animation: AnimationPlayer = $BugAnimation

@export var alive: bool = true
@export var health: int = 100
@export var max_speed: int = 200
var speed: int = max_speed
var direction: Vector2

func _process(_delta: float) -> void:
	direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	if active:
		look_at(Globals.player_pos)
		move_and_slide()
	
func hit() -> void:
	if can_be_hit:
		can_be_hit = false
		health -= 10
		$Timers/HitTimer.start()
		bug_animation.play("flash")
		$Node2D/HitParticles.emitting = true
	if health <= 0:   #not great design, the bug can still move and damage during the 0.5 sec for the particle emission
		alive = false
		await  get_tree().create_timer(0.5).timeout
		queue_free()

func _on_hit_timer_timeout() -> void:
	can_be_hit = true
	
func _on_attack_timer_timeout() -> void:
	if player_near:
		$AnimatedSprite2D.play("attack")
	
func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false
	$AnimatedSprite2D.stop()
	
func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_near = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_near = false
	$AnimatedSprite2D.play("walk")

func _on_animated_sprite_2d_animation_finished() -> void:
	if player_near:
		Globals.health -= 10
		$Timers/AttackTimer.start()
