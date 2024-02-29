extends Button


func Update():
	$HBoxContainer/CashAmount.text = str(PlayerInventory.Cash)
