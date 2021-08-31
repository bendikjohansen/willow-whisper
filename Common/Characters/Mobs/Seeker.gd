extends "res://Common/Characters/character.gd"

export(Resource) var target_type = preload("res://Common/Characters/Player.gd")


const VELOCITY = 550
const CLOSE_DISTANCE = 50
const POSITION_ABOVE_PLAYER = 50
const SPEED_TO_TOP_POSITION = 100

onready var animation = $AnimatedSprite

var velocity = Vector2.ZERO
var target_position = Vector2.ZERO
var target_node = null
var has_cycled_attack = false


func _on_AutoFollow_target_found(collision_point: Vector2, target):
	target_position = Vector2(target.position.x, target.position.y - POSITION_ABOVE_PLAYER)
	target_node = target


func _on_AutoFollow_target_lost():
	target_position = Vector2.ZERO


func _physics_process(_delta):
	var target_direction = target_position - global_position
	if target_position != Vector2.ZERO and is_instance_valid(target_node):
		var distance = target_direction.length()
		if distance < CLOSE_DISTANCE:
			position = position.move_toward(target_position, 10)
			animation.play("Shock")
			
			if animation.frame == 3 and not has_cycled_attack:
				has_cycled_attack = true
				_attack_target()
			elif animation.frame < 3:
				has_cycled_attack = false
		else:
			animation.play("Idle")
			velocity = move_and_slide(target_direction.normalized() * VELOCITY)
	else:
		animation.play("Idle")
		velocity = Vector2.ZERO


func _attack_target():
	if target_node != null and target_node.has_method("suffer_damage"):
		target_node.suffer_damage(1)
	
	
