extends Node

var PlayerStocks = {}
var DialogueData = {}
var Cash = 50

var WorkLevel = 0

signal DataUpdate
signal WorkUpdate
signal MoneyUpdate

func _ready():
	InitializeStocks()

func InitializeStocks():
	for company in StockData.GetCompanyNames():
		if company != "":
			PlayerStocks[company] = 0

func Reset():
	Cash = 50
	WorkLevel = 0
	InitializeStocks()
	DialogueData = {}

func GetTotalAssets():
	var total = Cash
	for stock in PlayerStocks.keys():
		total +=  PlayerStocks[stock] * StockData.GetCompanyStockPriceForDay(stock,DayTime.Day)
	return total

func CanAfford(price):
	return Cash >= price

func GetStocksOfCompany(companyName):
	return PlayerStocks[companyName]

func SetStocksOfCompany(companyName, amount):
	PlayerStocks[companyName] = amount

func AddMoney(amount):
	Cash += amount
	emit_signal("MoneyUpdate")

func RemoveCash(amount):
	Cash -= amount
	emit_signal("MoneyUpdate")

func IncreaseWorkLevel():
	WorkLevel += 1
	emit_signal("WorkUpdate")

func ResetWork():
	WorkLevel = 0
	emit_signal("WorkUpdate")

func GetDialogueData():
	return DialogueData

func GetDialogueDataProperty(property):
	if DialogueData.has(property):
		return str(DialogueData[property])
	else:
		return "null"

func SetDialogueData(property, value):
	DialogueData[property] = value
	emit_signal("DataUpdate")
