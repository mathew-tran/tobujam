extends Button


func _ready():
	grab_focus()

func _on_button_up():
	DayTime.HardReset()
	Game.HardReset()
	FadeScreen.TransitionLevel("res://Scenes/Prequel.tscn")
