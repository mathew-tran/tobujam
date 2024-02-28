extends Resource
class_name DialogueItem

@export_multiline  var Dialogue = "test"
@export var Options : Array[DialogueOption]
@export var UpdateVariables : Array[ValueSet]
@export var AudioSFXToPlay : AudioStream

func Get():
	return Dialogue

func HasOptions():
	return Options.is_empty() == false

func GetOptions():
	return Options

func SetValue():
	for setValue in UpdateVariables:
		setValue.SetValue()

func GetAudio():
	return AudioSFXToPlay
