extends Resource
class_name ValueSet

@export var VariableName : CustomVariable
@export var Value = true

func SetValue():
	if VariableName.GetName() != "default":
		Game.SetData(VariableName.GetName(), Value)
