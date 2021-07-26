extends "res://Common/Characters/Mobs/Mob.gd"

onready var weapon = $Weapon

func _on_Vision_target_found(collision_point: Vector2):
	if not weapon:
		return
	weapon.global_aim_position = collision_point
	weapon.shoot()
