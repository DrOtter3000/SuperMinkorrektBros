extends CharacterBody2D


var apple = load("res://Characters/apple.tscn")
const SPEED = 20.0
const JUMP_VELOCITY = -300.0
var direction = -1
var active = false
var attack_mode = false
var alive = true
var score_value = 150

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	add_gravity(delta)
	get_movement_direction()
	check_for_sprite_flip()
	check_for_apple_throw()
	move_and_slide()


func check_for_apple_throw():
	if attack_mode and velocity.y > 0 and alive:
		attack()
		attack_mode = false


func attack():
	var apple_instance = apple.instantiate()
	add_child(apple_instance)


func check_for_sprite_flip():
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	if player.global_position.x <= global_position.x:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true


func add_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func get_movement_direction():
	if is_on_wall():
		direction *= -1

	if direction < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false


func die():
	get_tree().get_first_node_in_group("Player").jump()
	alive = false
	Gamestate.score += score_value
	get_tree().call_group("GUI", "update_score")
	$AttackArea.monitoring = false
	$HurtArea.set_deferred("monitoring", false)
	$AnimationPlayer.play("die")


func _on_attack_area_body_entered(body):
	if body.name == "Player":
		print("player")
		$HurtArea.monitoring = false
		body.die()
		$HurtAreaTimer.start()


func jump():
	velocity.y = JUMP_VELOCITY


func _on_hurt_area_body_entered(body):
	die()


func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true


func _on_hurt_area_timer_timeout():
	$HurtArea.monitoring = true


func _on_jump_timer_timeout():
	jump()
	attack_mode = true
