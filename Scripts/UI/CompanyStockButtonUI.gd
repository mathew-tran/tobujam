extends Button

var bIsActive = false

var ProposedStockAmount = 0
var BeginningStockAmount = 0
var Price = 0
var CompanyName = ""
signal UpdateStock
func Populate(companyName, data):
	var lastDay = float(data[DayTime.Day - 1])
	var currentDay = float(data[DayTime.Day])
	CompanyName = companyName
	$HBoxContainer/CompanyName.text = companyName
	$HBoxContainer/StockPrice.text = str(currentDay)

	var percentage = (currentDay - lastDay)/lastDay
	percentage *= 100.0
	$HBoxContainer/StockChangePercent.text = str(snappedf(percentage, .01)) + "%"
	if percentage == 0:
		$HBoxContainer/TrendIcon.texture = load("res://Art/TrendNeutral.png")
	elif percentage > 0:
		$HBoxContainer/TrendIcon.texture = load("res://Art/TrendUp.png")
	else:
		$HBoxContainer/TrendIcon.texture = load("res://Art/TrendDown.png")

	BeginningStockAmount = Game.GetStocksOfCompany(companyName)
	ProposedStockAmount = Game.GetStocksOfCompany(companyName)
	$HBoxContainer/StockAmount.text = str(BeginningStockAmount)

	Price = currentDay
	$HBoxContainer/MoneyGained.text = str(0)


func _on_focus_entered():
	bIsActive = true


func _on_focus_exited():
	bIsActive = false

func _input(event):
	if bIsActive == false:
		return

	if event.is_action_pressed("A"):
		if Game.CanAfford(GetProposedMoney() + (BeginningStockAmount - (ProposedStockAmount + 1) ) * Price * -1):
			ProposedStockAmount += 1
	elif event.is_action_pressed("B"):
		ProposedStockAmount -= 1

	if ProposedStockAmount < 0:
		ProposedStockAmount = 0
	$HBoxContainer/StockAmount.text = str(ProposedStockAmount)

	var moneyToGain = GetProposedMoney()
	$HBoxContainer/MoneyGained.text = str(moneyToGain)
	emit_signal("UpdateStock")

func GetProposedMoney():
	return (BeginningStockAmount - ProposedStockAmount) * Price

func LockIn():
	Game.SetStocksOfCompany(CompanyName, ProposedStockAmount)
	Game.AddMoney(GetProposedMoney())
