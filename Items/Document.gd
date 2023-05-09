extends Area2D

var collectable = true
var score_value = 50


func _on_body_entered(body):
	if body.name == "Player" and collectable == true:
		collectable = false
		Gamestate.documents += 1
		Gamestate.score += score_value
		get_tree().call_group("GUI", "update_documents")
		get_tree().call_group("GUI", "update_score")
		$AnimationPlayer.play("die")
	
