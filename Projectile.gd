extends CharacterBody2D

#TODO: sometimes collides with invisible wall


const SPEED = 400
const JUMP_VELOCITY = -200.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = Vector2(1, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	if is_on_wall():
		queue_free()
	move_and_slide()


func movement(delta):
	velocity.x = direction.x * SPEED
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = JUMP_VELOCITY
		$AudioStreamPlayer.play()


func _on_hurt_area_body_entered(body):
	if body.has_method("die"):
		body.die()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
