extends Control


var gameover = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if Gamestate.lives < 0:
		$LblText.text = "Game Over \n \n" + "Score: " + str(Gamestate.score)
		$AnimationPlayer.play("game_over")
		
	else:
		$LblText.text = "x " + str(Gamestate.lives)
		$AnimationPlayer.play("hurt")


func restart_level():
	get_tree().change_scene_to_file(Gamestate.level)


func back_to_menu():
	get_tree().change_scene_to_file("res://main_menu.tscn")


