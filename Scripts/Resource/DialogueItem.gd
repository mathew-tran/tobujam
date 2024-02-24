extends Resource
class_name DialogueItem

@export var Dialogue = "test"
@export var Options : Array[DialogueOption]
func Get():
	return Dialogue

func HasOptions():
	return Options.is_empty() == false

func GetOptions():
	return Options
