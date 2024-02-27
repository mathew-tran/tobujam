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
	var companyNames = Game.GetCompanyNames()
	for index in range(0, len(CompanyStockButtons)):
		CompanyStockButtons[index].Populate(companyNames[index], Game.GetDataForCompany(companyNames[index]))
		CompanyStockButtons[index].connect("UpdateStock", Callable(self, "OnUpdateStock"))

func OnUpdateStock():
	var price = 0
	var companyNames = Game.GetCompanyNames()
	for index in range(0, len(CompanyStockButtons)):
		price += CompanyStockButtons[index].GetProposedMoney()

	Game.ProposedMoney = Game.Money + price
	$VBoxContainer/Trading/CompanyStockTotalUI2.UpdateTotal(Game.ProposedMoney)


func UpdateStockData():
	pass


func _on_visibility_changed():
	if visible:
		var companyNames = Game.GetCompanyNames()
		$VBoxContainer/Day.text = "Day " + str(DayTime.Day)
		$VBoxContainer/Trading/CompanyStockCashUI.Update()
		print("attempt update stocks")
		if len(CompanyStockButtons) > 0:
			print("update stocks")
			for index in range(0, len(CompanyStockButtons)):
				CompanyStockButtons[index].Populate(companyNames[index], Game.GetDataForCompany(companyNames[index]))
		CompanyStockButtons[0].grab_focus()

func _on_button_button_up():
	var companyNames = Game.GetCompanyNames()
	for index in range(0, len(CompanyStockButtons)):
		CompanyStockButtons[index].LockIn()

	Game.MoveToNextDay()
	visible = false
