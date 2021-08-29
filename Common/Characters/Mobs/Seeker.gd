extends "res://Common/Characters/character.gd"

export(Resource) var target_type = preload("res://Common/Characters/Player.gd")

const ACCELERATION = 1.5
const MAX_ACCELERATION = 670

onready var animation = $AnimatedSprite

var velocity = Vector2.ZERO
var target_position = Vector2.ZERO
var target_node = null
var has_cycled_attack = false


func _on_AutoFollow_target_found(collision_point: Vector2, target):
	target_position = collision_point - global_position
	target_node = target


func _on_AutoFollow_target_lost():
	target_position = Vector2.ZERO

func _process(_delta):
	if target_position != Vector2.ZERO and is_instance_valid(target_node):
		var distance = target_position.length()
		if distance < 50:
			var head_position = Vector2(target_position.x, target_position.y - 30.0)
			velocity = move_and_slide(head_position * 100)
			animation.play("Shock")
			
			if animation.frame == 3 and not has_cycled_attack:
				has_cycled_attack = true
				_attack_target()
			elif animation.frame < 3:
				has_cycled_attack = false
		else:
			animation.play("Idle")
			var relative_speed = (MAX_ACCELERATION - distance) * ACCELERATION
			velocity = move_and_slide(target_position * relative_speed * _delta)
	else:
		animation.play("Idle")
		velocity = Vector2.ZERO
		
func _attack_target():
	if target_node != null and target_node.has_method("suffer_damage"):
		target_node.suffer_damage(1)
	
	
