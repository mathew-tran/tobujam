extends Resource
class_name DialogueOption

@export var OptionName = "test"
@export var OptionUnlockCode : CustomVariable
@export var DialogueToPointTo : DialogueItem


func GetOptionName():
	return OptionName

func GetDialogueItem():
	return DialogueToPointTo

func IsOptionValid():
	if is_instance_valid(OptionUnlockCode) == false:
		return true

	if OptionUnlockCode.GetName() == "default":
		return true
	else:
		return Game.GetProperty(OptionUnlockCode.GetName()) == "true"
