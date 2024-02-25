extends Label



func _ready():
	UpdateUI()
	Game.connect("MoneyUpdate", Callable(self, "OnMoneyUpdate"))

func OnMoneyUpdate():
	UpdateUI()

func UpdateUI():
	text = "$" + str(Game.Money)
