extends PathFollow2D

var can_be_hit: bool = true
var alive: bool = true
var health: int = 300
var player_near: bool = false
@onready var flash_sprite1: Sprite2D = $Turret/Gun1/FlashSprite
@onready var flash_sprite2: Sprite2D = $Turret/Gun2/FlashSprite
@onready var line_2d1: Line2D = $Turret/Gun1/Line2D1
@onready var line_2d2: Line2D = $Turret/Gun2/Line2D2
@onready var car_animation: AnimationPlayer = $CarAnimation
@onready var flash_animation: AnimationPlayer = $FlashAnimation

func _ready() -> void:
	line_2d1.width = 0
	line_2d2.width = 0
	
func _process(delta: float) -> void:
	progress_ratio += 0.03 * delta
	if player_near:
		$Turret.look_at(Globals.player_pos)

func hit() -> void:
	if can_be_hit:
		can_be_hit = false
		health -= 10
		$Timers/HitTimer.start()
		flash_animation.play("flash")
	if health <= 0:
		alive = false
		queue_free()
	
func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_near = true
	car_animation.play("laser_load")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_near = false
	car_animation.pause()
	var tween = create_tween().set_parallel(true)
	tween.tween_property(line_2d1, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property(line_2d2, "width", 0, randf_range(0.1, 0.5))
	tween.tween_method($Turret.look_at,
					   Globals.player_pos,
					   $CarFront.global_position, 1)
	await tween.finished
	car_animation.stop()
		
func fire() -> void:
	if player_near:
		Globals.health -= 20
		flash_sprite1.modulate.a = 1
		flash_sprite2.modulate.a = 1
		var tween = create_tween().set_parallel(true)
		tween.tween_property(flash_sprite1, "modulate:a", 0, randf_range(0.1, 0.5))
		tween.tween_property(flash_sprite2, "modulate:a", 0, randf_range(0.1, 0.5))

func _on_hit_timer_timeout() -> void:
	can_be_hit = true


func _on_character_body_2d_hit_signal() -> void:
	hit()
