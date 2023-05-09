extends Control


func _on_btn_new_game_pressed():
	Gamestate.lives = 3
	Gamestate.documents = 0
	Gamestate.score = 0
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")


func _on_btn_credits_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")
