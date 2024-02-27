extends Button


func Update():
	$HBoxContainer/CashAmount.text = str(Game.Money)
