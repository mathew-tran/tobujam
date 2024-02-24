extends Resource
class_name DialogueListener

@export var VariableName : CustomVariable
@export var Value = true
@export var DialogueToPointTo : DialogueItem

func ShouldSwitch():
	if VariableName.Name != "default":
		return Game.GetProperty(VariableName.Name) == str(Value)
	return false
