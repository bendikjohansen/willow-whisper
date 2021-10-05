extends Node2D

signal target_found(collision_point)
signal target_lost

func _on_Vision_target_found(collision_point: Vector2, target):
	emit_signal('target_found', collision_point, target)

func _on_Vision_target_lost():
	emit_signal('target_lost')

