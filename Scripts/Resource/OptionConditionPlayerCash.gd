extends OptionCondition
class_name OptionConditionPlayerCash

@export var CashAmount = 10

func DoesConditionPass():
	return PlayerInventory.Cash >= CashAmount
