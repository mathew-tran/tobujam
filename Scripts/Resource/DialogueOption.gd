extends Resource
class_name DialogueOption

@export var OptionName = "test"
@export var DialogueToPointTo : DialogueItem
@export var OptionUnlockCode = "default"

func GetOptionName():
	return OptionName

func GetDialogueItem():
	return DialogueToPointTo

func IsOptionValid():
	if OptionUnlockCode == "default":
		return true
	else:
		return Game.GetData()[OptionUnlockCode]
