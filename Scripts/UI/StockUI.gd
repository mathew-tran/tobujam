extends Panel

var Data = {}

@onready var CompanyStockButtons = null
func _ready():
	CompanyStockButtons = [
	$VBoxContainer/Trading/CompanyStockUI,
	$VBoxContainer/Trading/CompanyStockUI2,
	$VBoxContainer/Trading/CompanyStockUI3,
	$VBoxContainer/Trading/CompanyStockUI4,
	$VBoxContainer/Trading/CompanyStockUI5,
	$VBoxContainer/Trading/CompanyStockUI6,
	$VBoxContainer/Trading/CompanyStockUI7,
	$VBoxContainer/Trading/CompanyStockUI8,
	$VBoxContainer/Trading/CompanyStockUI9,
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
		var companyNames = StockData.GetCompanyNames()
		$VBoxContainer/Day.text = "Day " + str(DayTime.Day)
		$VBoxContainer/Trading/CompanyStockCashUI.Update()
		print("attempt update stocks")
		if len(CompanyStockButtons) > 0:
			print("update stocks")
			for index in range(0, len(CompanyStockButtons)):
				CompanyStockButtons[index].Populate(companyNames[index], StockData.GetDataForCompany(companyNames[index]))
		CompanyStockButtons[0].grab_focus()

func _on_button_button_up():
	$AudioStreamPlayer2D.play()
	$VBoxContainer/Trading/HBoxContainer/Button.release_focus()
	await get_tree().create_timer(.8).timeout
	Game.MoveToNextDay()
	visible = false



