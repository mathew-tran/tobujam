extends Label



func _ready():
	UpdateUI()
	PlayerInventory.connect("WorkUpdate", Callable(self, "OnWorkLevel"))

func OnWorkLevel():
	UpdateUI()

func UpdateUI():
	if DayTime.IsLastDay() == false:
		text = "WORK:" + str(Definitions.GetWorkRating(PlayerInventory.WorkLevel))
	else:
		text = "FINAL DAY"
