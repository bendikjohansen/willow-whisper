extends RayCast2D

export(Resource) var target = preload("res://Common/Characters/Player.gd")
onready var tween = $VisionTween

var target_is_found = false

signal target_found(collision_point)
signal target_lost

func _ready():
	seek()

func _process(_delta: float) -> void:
	if is_colliding():
		var collider = get_collider()

		var target_was_found = target_is_found
		target_is_found = collider is target
		if target_was_found and not target_is_found:
			emit_signal('target_lost')
			tween.resume(self, 'rotation')

		if target_is_found:
			tween.stop(self, 'rotation')
			emit_signal("target_found", get_collision_point())

	if not target_is_found and not tween.is_active():
		seek()


func seek():
	if rotation < 0:
		tween.interpolate_property(self, 'rotation',  -PI / 8, 0, 1)
	else:
		tween.interpolate_property(self, 'rotation', 0, -PI / 8, 1)
	tween.start()
