extends PathFollow2D

var player_near: bool = false
@onready var flash_sprite1: Sprite2D = $Turret/Gun1/FlashSprite
@onready var flash_sprite2: Sprite2D = $Turret/Gun2/FlashSprite
@onready var line_2d1: Line2D = $Turret/Gun1/Line2D1
@onready var line_2d2: Line2D = $Turret/Gun2/Line2D2
@onready var car_animation: AnimationPlayer = $CarAnimation

func _ready() -> void:
	line_2d1.width = 0
	line_2d2.width = 0
	flash_sprite1.hide()
	flash_sprite2.hide()
	
func _process(delta: float) -> void:
	#progress_ratio += 0.03 * delta
	if player_near:
		$Turret.look_at(Globals.player_pos)
	else:
		$Turret.look_at($CarFront.global_position)
		
func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_near = true
	car_animation.play("laser_load")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_near = false
	car_animation.stop()

func fire() -> void:
	if player_near:
		Globals.health -= 20
		car_animation.play("gun_flash")
