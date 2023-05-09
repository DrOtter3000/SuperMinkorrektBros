extends CharacterBody2D

#TODO: Add invincible animation.

@export var Projectile: PackedScene
@export var BackgroundCity: PackedScene
@export var BackgroundTrees: PackedScene
const SPEED = 225.0
const JUMP_VELOCITY = -350.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#direction is used by projectile to find correct direction
var direction = Vector2(1, 0)
var readyToShoot = true
var invincible = false
var background_set = false


func _ready():
	get_tree().call_group("GUI", "update_lives")
	get_tree().call_group("GUI", "update_documents")
	get_tree().call_group("GUI", "update_score")


func _physics_process(delta):
	set_background()
	check_for_animation()
	check_number_of_documents()
	check_position()
	check_for_jump(delta)
	check_for_movement()
	check_for_shooting()
	move_and_slide()


func set_background():
	if background_set == false:
		if Gamestate.level == "res://Levels/level_1.tscn":
			var city = BackgroundCity.instantiate()
			$Camera2D.add_child(city)
			Gamestate.player = "RR"
		elif Gamestate.level == "res://Levels/level_2.tscn":
			var trees = BackgroundTrees.instantiate()
			$Camera2D.add_child(trees)
			Gamestate.player = "NW"
		
		background_set = true

func check_for_shooting():
	if Input.is_action_just_pressed("shoot") and readyToShoot:
		if Gamestate.diamonds == true:
			readyToShoot = false
			$ShootTimer.start()
			shoot()


func shoot():
	var Projectile_instance = Projectile.instantiate()
	get_node("../..").add_child(Projectile_instance)
	Projectile_instance.direction = direction
	Projectile_instance.global_position = global_position
	Projectile_instance.direction = direction


func check_for_animation():
	if Gamestate.player == "NW":
		if Gamestate.diamonds == false:
			if not is_on_floor():
				$AnimatedSprite2D.play("nw_jump")
			elif velocity.x != 0:
				$AnimatedSprite2D.play("nw_walk")
			else:
				$AnimatedSprite2D.play("nw_idle")
		else:
			if not is_on_floor():
				$AnimatedSprite2D.play("nw_jump_diamond")
			elif velocity.x != 0:
				$AnimatedSprite2D.play("nw_walk_diamond")
			else:
				$AnimatedSprite2D.play("nw_idle_diamond")
	else:
		if Gamestate.diamonds == false:
			if not is_on_floor():
				$AnimatedSprite2D.play("jump")
			elif velocity.x != 0:
				$AnimatedSprite2D.play("walk")
			else:
				$AnimatedSprite2D.play("idle")
		else:
			if not is_on_floor():
				$AnimatedSprite2D.play("jump_diamond")
			elif velocity.x != 0:
				$AnimatedSprite2D.play("walk_diamond")
			else:
				$AnimatedSprite2D.play("idle_diamond")
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		direction.x = -1
	elif velocity.x > 0: 
		$AnimatedSprite2D.flip_h = false
		direction.x = 1


func check_number_of_documents():
	if Gamestate.documents >= 10:
		Gamestate.documents = 0
		Gamestate.lives += 1
		get_tree().call_group("GUI", "update_documents")
		get_tree().call_group("GUI", "update_lives")


func check_for_jump(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()


func jump():
	velocity.y = JUMP_VELOCITY
	$AudioStreamPlayer.stream = load("res://Assets/SFX/jump.wav")
	$AudioStreamPlayer.play()


func check_for_movement():
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0


func check_position():
	if position.y >= 1024:
		die()
	elif is_on_ceiling():
		$AudioStreamPlayer.stream = load("res://Assets/SFX/SFX_pushShort.wav")
		$AudioStreamPlayer.play()


func hurt():
	if Gamestate.diamonds == true:
		Gamestate.diamonds = false
		invincible = true
		jump()
		$InvincibleTimer.start()
	else:
		die()


func die():
	if invincible:
		return
	else:
		Gamestate.documents = 0
		Gamestate.diamonds = false
		Gamestate.lives -= 1
		get_tree().change_scene_to_file("res://respawn_screen.tscn")


func _on_shoot_timer_timeout():
	readyToShoot = true


func _on_invincible_timer_timeout():
	invincible = false
