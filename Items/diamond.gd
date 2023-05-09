extends Area2D

var collectable = true
var score_value = 500


func _on_body_entered(body):
	if body.name == "Player" and collectable == true:
		collectable = false
		Gamestate.diamonds = true
		Gamestate.score += score_value
		$AnimationPlayer.play("die")
	
