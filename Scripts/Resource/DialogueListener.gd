extends Resource
class_name DialogueListener

@export var VariableName : CustomVariable
@export var Value = true
@export var DialogueToPointTo : DialogueItem

func ShouldSwitch():
	if VariableName.GetName() != "default":
		return Game.GetProperty(VariableName.GetName()) == str(Value)
	return false
