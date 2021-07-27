extends "res://Common/Characters/Character.gd"

onready var weapon = $Weapon

func _on_AutoAim_target_found(_collision_point):
	weapon.shoot()
