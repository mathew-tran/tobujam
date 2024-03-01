extends Label


func _ready():
	UpdateUI()
	DayTime.connect("DayIncrease", Callable(self, "OnDayIncrease"))

func OnDayIncrease():
	UpdateUI()

func UpdateUI():
	text = DayTime.GetDayString()
