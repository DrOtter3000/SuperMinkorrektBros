extends Sprite2D


@export var apple : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grow_timer_timeout():
	var new_apple = apple.instantiate()
#	$Markers.get_child($Markers.get_child_count()-1).add_child(new_apple)
	add_child(new_apple)
	new_apple.position = $Markers.get_child(randi() % $Markers.get_child_count() -1).position
