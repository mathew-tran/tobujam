extends Resource
class_name DialogueListener

@export var Name = "default"
@export var Value = true
@export var DialogueToPointTo : DialogueItem

func ShouldSwitch():
	if Name != "default":
		return Game.GetProperty(Name) == str(Value)
	return false
