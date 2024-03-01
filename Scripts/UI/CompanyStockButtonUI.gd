extends Button

var bIsActive = false

var ProposedStockAmount = 0
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

	ProposedStockAmount =  PlayerInventory.GetStocksOfCompany(companyName)
	$HBoxContainer/StockAmount.text = str(ProposedStockAmount)

	Price = currentDay
	$HBoxContainer/MoneyGained.text = str(ProposedStockAmount * Price)
	emit_signal("UpdateStock")


func _on_focus_entered():
	bIsActive = true


func _on_focus_exited():
	bIsActive = false

func _input(event):
	if bIsActive == false:
		StopTimer("not active")
		return

	if DayTime.IsLastDay():
		return

	if event.is_action("A"):
		if event.is_pressed():
			bPositive = true
			StartButtonTimer()
			#print("a press")
		elif event.is_action_released("A"):
			StopTimer("a")
		return

	if event.is_action("B"):
		if event.is_pressed():
			bPositive = false
			StartButtonTimer()
			#print("b press")
		else:
			StopTimer("b")
		return


func StopTimer(_who):
	$UpdateSpeed.stop()
	$Timer.stop()
	#print(who + "stopped")
	bStarted = false

func StartButtonTimer():
	if bStarted == false:
		bStarted = true
		$Timer.start()
		$UpdateSpeed.wait_time = DefaultWaitTime
		$UpdateSpeed.start()

	_on_update_speed_timeout()

func GetProposedMoney():
	return (ProposedStockAmount) * Price

func LockIn():
	PlayerInventory.SetStocksOfCompany(CompanyName, ProposedStockAmount)


func _on_update_speed_timeout():
	var currentStockAmount = ProposedStockAmount
	if bPositive:
		if PlayerInventory.CanAfford(Price):
			ProposedStockAmount += 1
			$AudioStreamPlayer2D.pitch_scale = 1
			PlayerInventory.RemoveCash(Price)
	else:
		ProposedStockAmount -= 1
		if ProposedStockAmount < 0:
			ProposedStockAmount = 0
		else:
			PlayerInventory.AddMoney(Price)
		$AudioStreamPlayer2D.pitch_scale = .8
	$HBoxContainer/StockAmount.text = str(ProposedStockAmount)

	LockIn()

	$HBoxContainer/MoneyGained.text = str(ProposedStockAmount * Price)
	emit_signal("UpdateStock")

	if currentStockAmount != ProposedStockAmount:
		$AudioStreamPlayer2D.play()


func _on_timer_timeout():
	$UpdateSpeed.wait_time -= .01
	if $UpdateSpeed.wait_time < MinWaitTime:
		$UpdateSpeed.wait_time = MinWaitTime
