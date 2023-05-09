extends StaticBody2D


@export var item : PackedScene


func add_item():
	var i = item.instantiate()
	add_child(i)
	i.position.y -= 16


func change_look():
	$AnimatedSprite2D.play("used")


func _on_area_2d_body_entered(body):
	$AudioStreamPlayer.stream = load("res://Assets/SFX/SFX_powerUp6.wav")
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("use")
	add_item()

