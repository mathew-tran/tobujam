extends Panel

var Data = {}

@onready var CompanyStockButtons = [
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
func _ready():
	ReadAndSaveStockData()
	await get_tree().create_timer(.5).timeout
	var companyNames = GetCompanyNames()
	for index in range(0, len(CompanyStockButtons)):
		CompanyStockButtons[index].Populate(companyNames[index], GetDataForCompany(companyNames[index]))


func ReadAndSaveStockData():
	var file = FileAccess.open("res://Content/Prices/Prices.txt", FileAccess.READ)
	while !file.eof_reached():
		var line = Array(file.get_csv_line())
		Data[Data.size()] = line
	file.close()

func GetDataForCompany(companyName):
	for line in Data:
		if Data[line][0] == companyName:
			var dataToGet = []
			var bFirst = true
			for element in Data[line]:
				if bFirst:
					bFirst = false
				else:
					dataToGet.append(element)
			return dataToGet
	return []

func GetCompanyNames():
	var names = []
	var bFirst = true
	for line in Data:
		if bFirst:
			bFirst = false
		else:
			names.append(Data[line][0])
	return names

func UpdateStockData():
	pass


func _on_visibility_changed():
	if visible:
		$VBoxContainer/Day.text = "Day " + str(DayTime.Day)
