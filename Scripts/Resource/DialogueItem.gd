extends Resource
class_name DialogueItem

@export var Dialogue = "test"
@export var Options : Array[DialogueOption]
@export var UpdateVariables : Array[ValueSet]
@export var VariableName = "default"
func Get():
	return Dialogue

func HasOptions():
	return Options.is_empty() == false

func GetOptions():
	return Options

func SetValue():
	for setValue in UpdateVariables:
		setValue.SetValue()
