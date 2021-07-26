extends "res://Common/Weapons/Weapon.gd"

var timer = Timer.new()
export(int) var _rate_of_fire = 60 setget set_rate_of_fire

func _ready():
	timer.wait_time = 60.0 / _rate_of_fire
	timer.connect("timeout", self, "_on_Timer_timeout")
	add_child(timer)

func set_rate_of_fire(rate_of_fire):
	timer.wait_time = 60.0 / rate_of_fire
	_rate_of_fire = rate_of_fire

func start_shooting():
	shoot()
	timer.start()

func stop_shooting():
	timer.stop()

func _on_Timer_timeout():
	shoot()

func shoot():
	pass
