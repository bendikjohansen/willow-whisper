extends Node2D

onready var barrel = $Barrel
onready var sprite = $Sprite

onready var initial_position = position
export(float) var radius = 15
var previous_aim_position = Vector2.ZERO
export(PackedScene) var Projectile = preload("res://Common/Weapons/Projectile.tscn")

enum WeaponType { UNKNOWN, FULLY_AUTOMATIC, SINGLE_FIRE }
var weapon_type = WeaponType.UNKNOWN

func _process(delta):
	var center_position = global_position - position
	var center_to_edge = previous_aim_position - center_position
	var center_to_edge_angle = center_to_edge.angle()
	var next_angle = lerp_angle(rotation, center_to_edge_angle, 0.3)

	sprite.flip_v = center_to_edge_angle > PI / 2 or center_to_edge_angle < -PI / 2
	rotation = next_angle
	position = initial_position.move_toward(center_to_edge, radius)

func _input(event):
	if event is InputEventMouseMotion:
		previous_aim_position = event.global_position

func get_weapon_type() -> int:
	return weapon_type
