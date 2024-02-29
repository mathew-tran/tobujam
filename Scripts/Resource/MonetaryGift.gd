extends Gift
class_name MonetaryGift

@export var Amount = 10

func Give():
	PlayerInventory.AddMoney(Amount)
