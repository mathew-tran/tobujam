extends Button

var bIsActive = false

var ProposedStockAmount = 0
var BeginningStockAmount = 0
var Price = 0
var CompanyName = ""
signal UpdateStock

var MinWaitTime = .1
var DefaultWaitTime = 1.3
var bPositive = false
var bStarted = false

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
	emit_signal("UpdateStock")


func _on_focus_entered():
	bIsActive = true


func _on_focus_exited():
	bIsActive = false

func _input(event):
	if bIsActive == false:
		return

	if event.is_action("A"):
		if event.is_pressed():
			bPositive = true
			StartButtonTimer()
			print("a press")
		elif event.is_action_released("A"):
			StopTimer("a")
		return

	if event.is_action("B"):
		if event.is_pressed():
			bPositive = false
			StartButtonTimer()
			print("b press")
		else:
			StopTimer("b")
		return


func StopTimer(who):
	$UpdateSpeed.stop()
	$Timer.stop()
	print(who + "stopped")
	bStarted = false

func StartButtonTimer():
	if bStarted == false:
		bStarted = true
		$Timer.start()
		$UpdateSpeed.wait_time = DefaultWaitTime
		$UpdateSpeed.start()

	_on_update_speed_timeout()

func GetProposedMoney():
	return (BeginningStockAmount - ProposedStockAmount) * Price

func LockIn():
	Game.SetStocksOfCompany(CompanyName, ProposedStockAmount)
	Game.AddMoney(GetProposedMoney())


func _on_update_speed_timeout():
	if bPositive:
		if Game.CanAfford(GetProposedMoney() + (BeginningStockAmount - (ProposedStockAmount + 1) ) * Price * -1):
			ProposedStockAmount += 1
	else:
		ProposedStockAmount -= 1
		if ProposedStockAmount < 0:
			ProposedStockAmount = 0
	$HBoxContainer/StockAmount.text = str(ProposedStockAmount)

	var moneyToGain = GetProposedMoney()
	$HBoxContainer/MoneyGained.text = str(moneyToGain)
	emit_signal("UpdateStock")


func _on_timer_timeout():
	$UpdateSpeed.wait_time -= .01
	if $UpdateSpeed.wait_time < MinWaitTime:
		$UpdateSpeed.wait_time = MinWaitTime
