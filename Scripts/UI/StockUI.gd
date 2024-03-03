extends Panel

var Data = {}

@onready var CompanyStockButtons = null
func _ready():

	$VBoxContainer/Trading/Label.visible =  DayTime.IsLastDay() == false
	$VBoxContainer/Trading/FinalDayText.visible = DayTime.IsLastDay()
	CompanyStockButtons = [
	$VBoxContainer/Trading/CompanyStockUI,
	$VBoxContainer/Trading/CompanyStockUI2,
	$VBoxContainer/Trading/CompanyStockUI3,
	$VBoxContainer/Trading/CompanyStockUI4,
	$VBoxContainer/Trading/CompanyStockUI5,
	$VBoxContainer/Trading/CompanyStockUI6,
	$VBoxContainer/Trading/CompanyStockUI7,
	]
	add_to_group("StockUI")
	var companyNames = StockData.GetCompanyNames()
	for index in range(0, len(CompanyStockButtons)):
		CompanyStockButtons[index].Populate(companyNames[index], StockData.GetDataForCompany(companyNames[index]))
		CompanyStockButtons[index].connect("UpdateStock", Callable(self, "OnUpdateStock"))

func OnUpdateStock():

	$VBoxContainer/Trading/CompanyStockTotalUI2.UpdateTotal(PlayerInventory.GetTotalAssets())
	$VBoxContainer/Trading/CompanyStockCashUI.Update()

func _input(event):
	if visible:
		if event.is_action_released("start"):
			$VBoxContainer/Trading/HBoxContainer/Button.grab_focus()

func UpdateStockData():
	pass


func _on_visibility_changed():
	if visible:
		$AudioStreamPlayer2D.pitch_scale = 1.3
		$AudioStreamPlayer2D.play()
		var companyNames = StockData.GetCompanyNames()
		$VBoxContainer/Day.text = str(DayTime.GetDayString())
		$VBoxContainer/Trading/CompanyStockCashUI.Update()
		print("attempt update stocks")
		if len(CompanyStockButtons) > 0:
			print("update stocks")
			for index in range(0, len(CompanyStockButtons)):
				CompanyStockButtons[index].Populate(companyNames[index], StockData.GetDataForCompany(companyNames[index]))
		CompanyStockButtons[0].grab_focus()

func _on_button_button_up():
	$AudioStreamPlayer2D.pitch_scale = 1
	$AudioStreamPlayer2D.play()
	$VBoxContainer/Trading/HBoxContainer/Button.release_focus()
	visible = false
	await get_tree().create_timer(1.5).timeout
	Game.MoveToNextDay()




