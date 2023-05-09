extends RigidBody2D


var SPEED = 3000
@onready var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D


func _ready():
	var direction = 1
	if player.global_position.x <= global_position.x:
		direction *= -1
	constant_force.x = direction * SPEED


func _physics_process(delta):
	constant_force.x *= 0.75


func _on_area_2d_body_entered(body):
	if body == player:
		body.die()
		queue_free()
	else:
		queue_free()
