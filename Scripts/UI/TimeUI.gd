extends Label



func _ready():
	UpdateUI()
	DayTime.connect("Increment", Callable(self, "OnIncrement"))

func OnIncrement():
	UpdateUI()

func UpdateUI():
	text = "ENERGY:" + str(DayTime.MaxTime - DayTime.CurrentTime) + "/" + str(DayTime.MaxTime)
