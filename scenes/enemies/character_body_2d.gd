extends CharacterBody2D

signal hit_signal

func hit() -> void:
	hit_signal.emit()
