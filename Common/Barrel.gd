extends Node2D

onready var initial_position = position
export(float) var radius = 15

export(PackedScene) var Projectile = preload("res://Common/Projectile.tscn")

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_position = event.global_position
		var parent_position = get_parent().global_position
		position = initial_position.move_toward(mouse_position - parent_position, radius)
	elif event.is_action_pressed("shoot"):
		var projectile = Projectile.instance()
		projectile.global_position = global_position
		projectile.direction = position - initial_position
		get_tree().root.add_child(projectile)
