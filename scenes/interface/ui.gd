extends CanvasLayer

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label

func _ready() -> void:
	update_laser_text()
	update_grenade_text()
	
func update_laser_text() -> void:
	laser_label.text = str(Globals.laser_amount)
	
func update_grenade_text() -> void:
	grenade_label.text = str(Globals.grenade_amount)
