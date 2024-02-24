extends Resource
class_name ValueSet

@export var VariableName : CustomVariable
@export var Value = true

func SetValue():
	if VariableName.Name != "default":
		Game.SetData(VariableName.Name, Value)
