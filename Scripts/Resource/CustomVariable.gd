extends Resource
class_name CustomVariable

var Name = ""

func GetName():
	var name = resource_path.get_file().trim_suffix(".tres")
	return name

