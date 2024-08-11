extends CharacterBody2D

var direction := Vector2.RIGHT
const SPEED := 250
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	velocity = direction * SPEED
	move_and_slide()


func _on_timer_timeout():
	if direction == Vector2.RIGHT:
		direction = Vector2.LEFT
		$Sprite2D.flip_v = true
	else:
		direction = Vector2.RIGHT
		$Sprite2D.flip_v = false

func hit():
	print("damage!")
