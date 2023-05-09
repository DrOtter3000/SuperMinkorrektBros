extends CanvasLayer


func update_scores():
	pass


func update_lives():
	$LblLives.text = "x " + str(Gamestate.lives)


func update_documents():
	$LblDocuments.text ="x " + str("%0*d" % [2, Gamestate.documents])


func update_score():
	$LblScoreCounter.text ="%0*d" % [6, Gamestate.score]


func update_time(timeLeft):
	$LblTimeCounter.text = str("%0*d" % [2, timeLeft])
