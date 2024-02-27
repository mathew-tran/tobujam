extends Node

signal EnterDialogue
signal ExitDialogue
signal SendDialogue(data)

var GridSize = Vector2(10, 10)

signal DataUpdate
signal WorkUpdate

var Data = {
}

var WorkLevel = 0
var Money = 50
signal MoneyUpdate

var bIsInDialogue = false

var StockData = {}
var Stocks = {}

func _ready():
	Game.ReadAndSaveStockData()
	for company in GetCompanyNames():
		Stocks[company] = 0

func GetStocksOfCompany(companyName):
	return Stocks[companyName]

func SetStocksOfCompany(companyName, amount):
	Stocks[companyName] = amount

func DoTrading():
	var result = get_tree().get_nodes_in_group("StockUI")
	if result:
		result[0].visible = true

func MoveToNextDay():
	ResetWork()
	DayTime.MoveNextDay()
	Game.TeleportPlayer("StartPoint")

func AddMoney(amount):
	Money += amount
	emit_signal("MoneyUpdate")

func IncreaseWorkLevel():
	WorkLevel += 1
	emit_signal("WorkUpdate")

func ResetWork():
	WorkLevel = 0
	emit_signal("WorkUpdate")

func GetData():
	return Data

func SetData(property, value):
	Data[property] = value
	emit_signal("DataUpdate")

func GetProperty(property):
	if Data.has(property):
		return str(Data[property])
	else:
		return "null"

func BroadcastSendDialogue(data):
	emit_signal("SendDialogue", data)

func BroadcastEnterDialogue():
	emit_signal("EnterDialogue")
	bIsInDialogue = true

func BroadcastExitDialogue():
	emit_signal("ExitDialogue")
	bIsInDialogue = false

func TeleportPlayer(pointName):
	var movePoints = get_tree().get_nodes_in_group("MovePoint")
	for point in movePoints:
		if point.name == pointName:
			point.MovePlayer()

func ReadAndSaveStockData():
	var file = FileAccess.open("res://Content/Prices/Prices.txt", FileAccess.READ)
	while !file.eof_reached():
		var line = Array(file.get_csv_line())
		StockData[StockData.size()] = line
	file.close()

func GetDataForCompany(companyName):
	for line in StockData:
		if StockData[line][0] == companyName:
			var dataToGet = []
			var bFirst = true
			for element in StockData[line]:
				if bFirst:
					bFirst = false
				else:
					dataToGet.append(element)
			return dataToGet
	return []

func GetCompanyNames():
	var names = []
	var bFirst = true
	for line in StockData:
		if bFirst:
			bFirst = false
		else:
			names.append(StockData[line][0])
	return names
