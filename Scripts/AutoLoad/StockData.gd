extends Node

var Data = {

}

var CompanyData = {}

func _ready():
	ReadAndSaveStockData()
	PopulateCompanyData()

func PopulateCompanyData():
	for company in GetCompanyNames():
		CompanyData[company] = GetDataForCompany(company)

func GetCompanyStockPriceForDay(companyName, day):
	return int(CompanyData[companyName][day])

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
