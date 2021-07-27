extends Node2D

onready var barrel = $Barrel
onready var sprite = $Sprite

onready var initial_position = position
export(float) var radius = 15
var global_aim_position = Vector2.ZERO
export(PackedScene) var Projectile = preload("res://Common/Weapons/Projectile.tscn")

enum WeaponType { UNKNOWN, FULLY_AUTOMATIC, SINGLE_FIRE }
var weapon_type = WeaponType.UNKNOWN

func _process(_delta):
	var center_position = global_position - position
	var aim_at = global_aim_position - center_position
	var aim_angle = aim_at.angle()
	var next_angle = lerp_angle(rotation, aim_angle, 0.3)

	sprite.flip_v = aim_angle > PI / 2 or aim_angle < -PI / 2
	rotation = next_angle
	position = initial_position.move_toward(aim_at, radius)

func get_weapon_type() -> int:
	return weapon_type
