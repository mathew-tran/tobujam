extends OptionCondition
class_name OptionConditionCheck

@export var VariableReference : CustomVariable

@export var CheckedValue : CheckValue

func DoesConditionPass():
	var data = PlayerInventory.GetDialogueDataProperty(VariableReference.GetName())
	if  data != "null":
		return int(data) == CheckedValue.GetValue()
	else:
		PlayerInventory.SetDialogueData(VariableReference.GetName(), VariableReference.GetValue())
	return VariableReference.GetValue() == CheckedValue.GetValue()
