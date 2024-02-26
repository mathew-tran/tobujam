extends Panel

var Data = {}

func _ready():
	ReadAndSaveStockData()
	for company in GetCompanyNames():
		print(company)
		var companyData = GetDataForCompany(company)
		for element in companyData:
			print(element)
			pass

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
