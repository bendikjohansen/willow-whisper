extends RayCast2D

export(Resource) var target_type = preload("res://Common/Characters/Player.gd")

onready var targets = {}
onready var targets_found = {}

signal target_found(collision_point)
signal target_lost

func _process(_delta):
	for target in targets.values():
		rotate(get_angle_to(target.global_position))
		if is_colliding():
			var collider = get_collider()

			var was_target_found = targets_found[target]
			targets_found[target] = collider is target_type
			if targets_found[target]:
				emit_signal("target_found", get_collision_point())
			elif was_target_found:
				emit_signal("target_lost")

func _on_FieldOfView_body_entered(body):
	if body is target_type and not body in targets:
		targets[body] = body
		targets_found[body] = false

func _on_FieldOfView_body_exited(body):
	if body is target_type and body in targets:
		targets.erase(body)
		targets_found[body] = false
