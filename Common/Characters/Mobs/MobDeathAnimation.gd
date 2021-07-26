extends AnimatedSprite

func _on_MobDeathAnimation_animation_finished():
	queue_free()
