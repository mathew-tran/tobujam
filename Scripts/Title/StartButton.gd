extends Button


func _ready():
	grab_focus()

func _on_button_up():
	DayTime.HardReset()
	Game.HardReset()
	get_tree().change_scene_to_file("res://Scenes/Prequel.tscn")
