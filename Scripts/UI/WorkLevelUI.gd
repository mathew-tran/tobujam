extends Label



func _ready():
	UpdateUI()
	PlayerInventory.connect("WorkUpdate", Callable(self, "OnWorkLevel"))

func OnWorkLevel():
	UpdateUI()

func UpdateUI():
	text = "Work Level:" + str(PlayerInventory.WorkLevel)
