extends Resource
class_name CustomVariable

var Name = ""

@export var value : int

func GetName():
	var name = resource_path.get_file().trim_suffix(".tres")
	return name

func GetValue():
	return value
