extends "res://Common/Weapon.gd"

onready var timer = $Timer

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		_shoot()
		timer.start()
	elif Input.is_action_just_released("shoot"):
		timer.stop()

func _on_Timer_timeout():
	_shoot()

func _shoot():
	var projectile = Projectile.instance()
	projectile.angle = randf() * PI / 16 - PI / 32
	projectile.global_position = barrel.global_position
	projectile.direction = position - initial_position
	get_tree().root.add_child(projectile)
