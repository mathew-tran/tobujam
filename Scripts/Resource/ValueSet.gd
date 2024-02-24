extends Resource
class_name ValueSet

@export var Name = "default"
@export var Value = true

func SetValue():
	if Name != "default":
		Game.SetData(Name, Value)
