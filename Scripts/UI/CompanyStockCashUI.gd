extends Button


func _ready():
	$HBoxContainer/CashAmount.text = str(Game.Money)
