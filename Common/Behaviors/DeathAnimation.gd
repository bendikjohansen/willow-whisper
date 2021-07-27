extends Node2D

export(PackedScene) var DeathAnimation = preload("res://Common/Animations/Explosion.tscn")

func _on_Character_dies():
	var death_animation = DeathAnimation.instance()
	death_animation.global_position = global_position
	death_animation.play()
	get_tree().root.add_child(death_animation)
