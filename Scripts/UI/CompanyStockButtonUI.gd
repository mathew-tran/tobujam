extends Button


func Populate(companyName, data):
	var lastDay = float(data[DayTime.Day - 1])
	var currentDay = float(data[DayTime.Day])
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

	$HBoxContainer/StockAmount.text = str(Game.GetStocksOfCompany(companyName))
