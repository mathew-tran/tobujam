extends Action
class_name TakeMoney

@export var Amount = 10

func Give():
	PlayerInventory.RemoveCash(Amount)
