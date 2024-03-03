extends Resource
class_name DialogueOwner

@export var Name = "name"
@export var OwnerColor : Color
@export var MinPitch = 1.0
@export var MaxPitch = 1.2
@export var Sound : AudioStreamWAV

func Get():
	return Name

func GetColor():
	return OwnerColor

func GetPitch():
	return randf_range(MinPitch, MaxPitch)

func GetSound():
	return Sound
