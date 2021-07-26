extends "res://Common/Weapons/AutomaticWeapon.gd"

func shoot():
	var projectile = Projectile.instance()
	projectile.angle = randf() * PI / 16 - PI / 32
	projectile.global_position = barrel.global_position
	projectile.direction = position - initial_position
	get_tree().root.add_child(projectile)
