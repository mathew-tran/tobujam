extends Button


func _ready():
	grab_focus()

func _on_button_up():
	get_tree().change_scene_to_file("res://Scenes/Prequel.tscn")
