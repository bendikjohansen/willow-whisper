extends "res://Common/Characters/Character.gd"

export(PackedScene) var DeathAnimation = preload("res://Common/Characters/Mobs/MobDeathAnimation.tscn")

func on_death():
	.on_death()

	var death_animation = DeathAnimation.instance()
	death_animation.global_position = global_position
	death_animation.play()
	get_tree().root.add_child(death_animation)
