extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$LblCredits.text = "
		Idea - DrOtter3000 \n
		Graphics - DrOtter3000 \
		Sound - Some HumbleBundle SFX
		Development - DrOtter3000
		Design - DrOtter3000
		Testing - Communitytesterarray
	"


func _process(delta):
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file("res://main_menu.tscn")




func _on_timer_timeout():
	pass # Replace with function body.
