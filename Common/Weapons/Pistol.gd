extends "res://Common/Weapons/SingleFireWeapon.gd"

func shoot():
	var projectile = Projectile.instance()
	projectile.global_position = barrel.global_position
	projectile.direction = position - initial_position
	get_tree().root.add_child(projectile)
