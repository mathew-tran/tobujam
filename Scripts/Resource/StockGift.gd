extends Action
class_name StockGift

@export var Amount = 10
@export var StockNameIndex = 3

func Give():
	var companyName = StockData.GetCompanyNames()[StockNameIndex]
	PlayerInventory.SetStocksOfCompany(companyName, PlayerInventory.GetStocksOfCompany(companyName) + Amount)
