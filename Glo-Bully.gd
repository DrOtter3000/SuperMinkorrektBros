extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0
var direction = -1
var active = false
var score_value = 100


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	check_position()
	add_gravity(delta)
	get_movement_direction()
	movement()
	move_and_slide()


func movement():
	if active:
		velocity.x = SPEED * direction
	else:
		velocity.x = 0


func check_position():
	if position.y >= 1024:
		queue_free()


func add_gravity(delta):
	if not is_on_floor() or not active:
		velocity.y += gravity * delta


func get_movement_direction():
	if is_on_wall():
		direction *= -1

	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false


func die():
	active = false
	$AttackArea.monitoring = false
	$HurtArea.set_deferred("monitoring", false)
	$AnimationPlayer.play("die")


func _on_attack_area_body_entered(body):
	if "Player" in body.name:
		body.hurt()


func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true	



func _on_hurt_area_area_entered(area):
	if area.name == "PlayerAttackArea":
		get_tree().call_group("Player", "jump")
		Gamestate.score += score_value
		get_tree().call_group("GUI", "update_score")
		die()
