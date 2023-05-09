extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$LblScore.text = setTextForScore()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("jump"):
		nextLevel()


func setTextForScore():
	var timeToScore = Gamestate.time_left * 10
	var text = "Score: " + str(Gamestate.score) + "\n" + "Time Score: " + str(Gamestate.time_left) + " x 10 = " + str(timeToScore) + "\n" + "Total Score " + str(Gamestate.score + timeToScore)
	Gamestate.score += timeToScore
	return(text)


func nextLevel():
	if Gamestate.level == "res://Levels/level_1.tscn":
		get_tree().change_scene_to_file("res://Levels/level_2.tscn")
	elif Gamestate.level == "res://Levels/level_2.tscn":
		get_tree().change_scene_to_file("res://Levels/level_3.tscn")
	elif Gamestate.level == "res://Levels/level_3.tscn":
		get_tree().change_scene_to_file("res://Levels/level_4.tscn")
	elif Gamestate.level == "res://Levels/level_4.tscn":
		get_tree().change_scene_to_file("res://Levels/level_5.tscn")
	elif Gamestate.level == "res://Levels/level_5.tscn":
		get_tree().change_scene_to_file("res://credits.tscn")
		
