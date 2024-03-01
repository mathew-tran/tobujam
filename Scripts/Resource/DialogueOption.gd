extends Resource
class_name DialogueOption

@export var OptionName = "test"
@export var OptionUnlockCode : OptionCondition
@export var DialogueToPointTo : DialogueItem


func GetOptionName():
	return OptionName

func GetDialogueItem():
	return DialogueToPointTo

func IsOptionValid():
	if is_instance_valid(OptionUnlockCode) == false:
		return true
	else:
		return OptionUnlockCode.DoesConditionPass()
