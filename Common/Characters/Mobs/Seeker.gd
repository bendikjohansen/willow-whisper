extends "res://Common/Characters/character.gd"

export(Resource) var target_type = preload("res://Common/Characters/Player.gd")

const VELOCITY = 550
const CLOSE_DISTANCE = 50
const POSITION_ABOVE_PLAYER = 50
const SPEED_TO_TOP_POSITION = 100
const RADIANS_TO_ORDINAL_SECTORS = PI/8

onready var animation = $AnimatedSprite

var velocity = Vector2.ZERO
var target_position = Vector2.ZERO
var target_node = null
var has_cycled_attack = false

const SEEKER_ANIMATIONS = {
	shock 		= "Shock",
	idle 		= "Idle",
	north_east 	= "NE",
	north 		= "N",
	north_west 	= "NW",
	west 		= "W",
	south_west 	= "SW",
	south 		= "S",
	south_east 	= "SE",
	east 		= "E"
}


func _on_AutoFollow_target_found(_collision_point: Vector2, target):
	target_position = Vector2(target.position.x, target.position.y - POSITION_ABOVE_PLAYER)
	target_node = target


func _on_AutoFollow_target_lost():
	target_position = Vector2.ZERO


func _physics_process(_delta):
	var target_direction = target_position - global_position
	if target_position != Vector2.ZERO and is_instance_valid(target_node):
		_move_seeker(target_direction)
	else:
		animation.play(SEEKER_ANIMATIONS.idle)
		velocity = Vector2.ZERO


func _attack_target():
	if target_node != null and target_node.has_method("suffer_damage"):
		target_node.suffer_damage(1)
	
	
func _move_seeker(target_direction: Vector2):
	var distance = target_direction.length()
	if distance < CLOSE_DISTANCE:
		position = position.move_toward(target_position, 10)
		animation.play(SEEKER_ANIMATIONS.shock)
		
		if animation.frame == 3 and not has_cycled_attack:
			has_cycled_attack = true
			_attack_target()
		elif animation.frame < 3 and has_cycled_attack:
			has_cycled_attack = false
	else:
		_handle_animation(target_direction)
		velocity = move_and_slide(target_direction.normalized() * VELOCITY)
		

func _handle_animation(target_direction: Vector2):
	var target_angle = target_direction.angle()
	var north = -PI/2
	var east = 0
	var south = PI/2
	var west = PI # and -PI

	# Ikke døm meg plis
	if target_angle <= north + RADIANS_TO_ORDINAL_SECTORS and target_angle >= north - RADIANS_TO_ORDINAL_SECTORS:
		animation.play(SEEKER_ANIMATIONS.north)
	elif target_angle > north + RADIANS_TO_ORDINAL_SECTORS and target_angle < east - RADIANS_TO_ORDINAL_SECTORS:
		animation.play(SEEKER_ANIMATIONS.north_east)
	elif target_angle <= east + RADIANS_TO_ORDINAL_SECTORS and target_angle >= east - RADIANS_TO_ORDINAL_SECTORS:
		animation.play(SEEKER_ANIMATIONS.east)
	elif target_angle > east + RADIANS_TO_ORDINAL_SECTORS and target_angle < south - RADIANS_TO_ORDINAL_SECTORS:
		animation.play(SEEKER_ANIMATIONS.south_east)
	elif target_angle <= south + RADIANS_TO_ORDINAL_SECTORS and target_angle >= south - RADIANS_TO_ORDINAL_SECTORS:
		animation.play(SEEKER_ANIMATIONS.south)
	elif target_angle > south + RADIANS_TO_ORDINAL_SECTORS and target_angle < west - RADIANS_TO_ORDINAL_SECTORS:
		animation.play(SEEKER_ANIMATIONS.south_west)
	elif target_angle <= -(west - RADIANS_TO_ORDINAL_SECTORS) or target_angle >= west - RADIANS_TO_ORDINAL_SECTORS:
		animation.play(SEEKER_ANIMATIONS.west)
	elif target_angle < north - RADIANS_TO_ORDINAL_SECTORS and target_angle > -(west - RADIANS_TO_ORDINAL_SECTORS):
		animation.play(SEEKER_ANIMATIONS.north_west)
	
