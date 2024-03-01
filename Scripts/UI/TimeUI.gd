extends Label



func _ready():
	UpdateUI()
	DayTime.connect("Increment", Callable(self, "OnIncrement"))

func OnIncrement():
	UpdateUI()

func UpdateUI():
	text = "TIME:" + str(DayTime.CurrentTime) + "/" + str(DayTime.MaxTime)
