extends "res://Common/Characters/character.gd"

export(Resource) var target_type = preload("res://Common/Characters/Player.gd")

const VELOCITY = 550
const CLOSE_DISTANCE = 150
const POSITION_ABOVE_PLAYER = 50
const SPEED_TO_TOP_POSITION = 100
const RADIANS_TO_ORDINAL_SECTORS = PI/8

onready var animation = $AnimatedSprite
onready var attackTimer = $AttackInterval

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
		attackTimer.stop()
		animation.play(SEEKER_ANIMATIONS.idle)
		velocity = Vector2.ZERO
	
	
func _move_seeker(target_direction: Vector2):
	var distance = target_direction.length()
	if distance < CLOSE_DISTANCE:
		position = position.move_toward(target_position, 10)
		if attackTimer.is_stopped():
			attack()
			attackTimer.start()
	else:
		attackTimer.stop()
		_handle_animation(target_direction)
		velocity = move_and_slide(target_direction.normalized() * VELOCITY)
		

func _handle_animation(target_direction: Vector2):
	var sign_direction = target_direction.normalized().round()
	var animation_name = SEEKER_ANIMATIONS.idle

	if sign_direction == Vector2.UP:
		animation_name = SEEKER_ANIMATIONS.north
	elif sign_direction == Vector2.UP + Vector2.RIGHT:
		animation_name = SEEKER_ANIMATIONS.north_east
	elif sign_direction == Vector2.RIGHT:
		animation_name = SEEKER_ANIMATIONS.east
	elif sign_direction == Vector2.DOWN + Vector2.RIGHT:
		animation_name = SEEKER_ANIMATIONS.south_east
	elif sign_direction == Vector2.DOWN:
		animation_name = SEEKER_ANIMATIONS.south
	elif sign_direction == Vector2.DOWN + Vector2.LEFT:
		animation_name = SEEKER_ANIMATIONS.south_west
	elif sign_direction == Vector2.LEFT:
		animation_name = SEEKER_ANIMATIONS.west
	elif sign_direction == Vector2.UP + Vector2.LEFT:
		animation_name = SEEKER_ANIMATIONS.north_west
		
	animation.play(animation_name)
	

func attack():
	animation.play(SEEKER_ANIMATIONS.shock)


func _on_AttackInterval_timeout():
	attack()


func _on_AnimatedSprite_animation_finished():
	if animation.animation != SEEKER_ANIMATIONS.shock:
		return
		
	if target_node != null and target_node.has_method("suffer_damage"):
		target_node.suffer_damage(1)
		animation.play(SEEKER_ANIMATIONS.idle)
