extends Control

var DialogueData = {}

@onready var DescriptionText = $Panel/Description
@onready var TitleText = $Panel/Panel/Speaker

var DialogueToSay = []
var DefaultCharacterDelay = .1

signal StartDialogue
signal EndDialogue

func _enter_tree():
	visible = false

func _ready():
	DescriptionText.visible_characters = 0
	DescriptionText.text = ""
	SetDialogue({
		"Speaker" : "Janitor",
		"Description" : "Testing dialogue.... this is a long sentence with no point to it oh Testin testing testin",
		"Cadence" : .15
	})

func SplitString(s: String, length: int):
	var result = []
	var start = 0
	while start < s.length():
		result.append(s.substr(start, length))
		start += length
	return result

func SetDialogue(data):
	emit_signal("StartDialogue")
	DialogueData = data

	$TextureRect.visible = false
	$AnimationPlayer.stop()
	visible = true

	DialogueToSay = SplitString(data["Description"], 80)

	if data.has("Cadence"):
		$Timer.wait_time = data["Cadence"]
	else:
		$Timer.wait_time = DefaultCharacterDelay
	StartText()

func StartText():
	DescriptionText.visible_characters = 0
	TitleText.text = DialogueData["Speaker"]
	DescriptionText.text = DialogueToSay[0]

	$Timer.start()


func _input(event):
	if DialogueData == {} or DialogueToSay.is_empty():
		return

	if event.is_action_released("B"):
		DescriptionText.visible_characters = len(DialogueToSay[0])
		_on_timer_timeout()

	if event.is_action_released("A"):
		if IsLineFinished():
			if CanGetNextLine():
				StartText()
			else:
				CloseDialogue()
		else:
			if $Timer.wait_time != .005:
				$Timer.wait_time = .005
				$Timer.start()

func CloseDialogue():
	visible = false
	emit_signal("EndDialogue")

func _on_timer_timeout():
	DescriptionText.visible_characters += 1
	if IsLineFinished():
		print("done")
		$Timer.stop()
		$TextureRect.visible = true
		$AnimationPlayer.play("animateArrow")

func IsLineFinished():
	return DescriptionText.visible_characters >= len(DialogueToSay[0])

func CanGetNextLine():
	DialogueToSay.pop_front()
	if DialogueToSay.is_empty():
		return false
	return true
