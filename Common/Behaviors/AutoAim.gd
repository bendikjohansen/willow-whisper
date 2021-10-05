extends Node2D

onready var Weapon = preload("res://Common/Weapons/Weapon.gd")
export(NodePath) var weapon_path = @"../Weapon"
onready var weapon = get_node(weapon_path)

signal target_found(collision_point)
signal target_lost

func _on_Vision_target_found(collision_point: Vector2, _target):
	if not weapon or not weapon is Weapon:
		return
	weapon.global_aim_position = collision_point
	emit_signal('target_found', collision_point)

func _on_Vision_target_lost():
	emit_signal('target_lost')
