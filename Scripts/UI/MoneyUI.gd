extends Label


signal MoneyUpdate


func _ready():
	UpdateUI()
	PlayerInventory.connect("MoneyUpdate", Callable(self, "OnMoneyUpdate"))

func OnMoneyUpdate():
	UpdateUI()

func UpdateUI():
	text = str(PlayerInventory.Cash)
