extends Resource
class_name ValueSet

@export var VariableName : CustomVariable
@export var Value = 0

func SetValue():
	if is_instance_valid(VariableName):
		PlayerInventory.SetDialogueData(VariableName.GetName(), Value)
