extends "res://Common/Weapon.gd"

func _input(event):
	if event.is_action_pressed("shoot"):
		var projectile = Projectile.instance()
		projectile.global_position = barrel.global_position
		projectile.direction = position - initial_position
		get_tree().root.add_child(projectile)
