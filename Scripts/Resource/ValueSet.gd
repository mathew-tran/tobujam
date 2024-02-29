extends Resource
class_name ValueSet

@export var VariableName : CustomVariable
@export var Value = true

func SetValue():
	if VariableName.GetName() != "default":
		PlayerInventory.SetDialogueData(VariableName.GetName(), Value)
