extends Node

signal EnterDialogue
signal ExitDialogue
signal SendDialogue(data)

var GridSize = Vector2(10, 10)

signal DataUpdate
signal WorkUpdate



var ColorData = {
	"brown" : "987b4e",
	"blue" : "4896cd",
	"grey" : "585b65",
	"purple" : "734f99",
	"red": "bb3330",
	"darkbrown" : "5f372c",
	"pink" : "e7ccb4",
	"orange" : "b67b2e",
	"white" : "fcfaf6",
	"black" : "13110d",
	"lightblue": "9aa5bf",
	"navyblue" : "142c4b",
	"tourquise" : "426773",
	"silver" : "91877b",
	"palegreen" : "aab69a",
	"darkgreen" : "474f2d"
}

var Data = {
}

var WorkLevel = 0
var Money = 50
var ProposedMoney = 50
signal MoneyUpdate

var bIsInDialogue = false
var bBlockDialogue =false

var StockData = {}
var Stocks = {}

var IncreaseRate = 1

signal FadeIn
signal FadeOut

func BroadcastFadeIn():
	emit_signal("FadeIn")

func BroadcastFadeOut():
	emit_signal("FadeOut")

func _ready():
	Game.ReadAndSaveStockData()
	for company in GetCompanyNames():
		Stocks[company] = 0

func GetStocksOfCompany(companyName):
	return Stocks[companyName]

func SetStocksOfCompany(companyName, amount):
	Stocks[companyName] = amount

func CanAfford(price):
	return ProposedMoney >= price

func DoTrading():
	bBlockDialogue = true
	await get_tree().create_timer(.8).timeout


	var result = get_tree().get_nodes_in_group("StockUI")
	if result:
		result[0].visible = true
	ProposedMoney = Money
	Game.BroadcastFadeOut()

func MoveToNextDay():
	ResetWork()
	DayTime.MoveNextDay()
	Game.TeleportPlayer("StartPoint")
	bBlockDialogue = false

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

func CanEnterDialogue():
	return bIsInDialogue == false and bBlockDialogue == false

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
