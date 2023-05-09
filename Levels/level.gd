extends Node2D


@onready var levelTime = $LevelTimer.time_left


func _ready():
	Gamestate.level = "res://Levels/level_.tscn"


func _process(delta):
	get_tree().call_group("GUI", "update_time", levelTime)
	levelTime = $LevelTimer.time_left
	Gamestate.time_left = int($LevelTimer.time_left)
	#TODO: Fasten up BG-music at levelTime <= 10 sec.


func _on_level_timer_timeout():
	get_tree().get_first_node_in_group("Player").die() 
