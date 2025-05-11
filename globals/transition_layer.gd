extends CanvasLayer

@onready var anim = $AnimationPlayer

func change_scene(target: String) -> void:
	anim.play("fade_to_black")
	await anim.animation_finished
	get_tree().change_scene_to_file(target)
	anim.play_backwards("fade_to_black")
