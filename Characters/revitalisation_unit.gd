extends Node2D


@export var water: PackedScene

func _on_water_timer_timeout():
	var newWater = water.instantiate()
	add_child(newWater)
	newWater.position.y -= 40
