extends Label



func _ready():
	UpdateUI()
	Game.connect("WorkUpdate", Callable(self, "OnWorkLevel"))

func OnWorkLevel():
	UpdateUI()

func UpdateUI():
	text = "Work Level:" + str(Game.WorkLevel)
