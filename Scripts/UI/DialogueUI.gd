extends Control

var DialogueData = {}

@onready var DescriptionText = $Panel/Description
@onready var TitleText = $Panel/Panel/Speaker

var DialogueToSay = []
var DefaultCharacterDelay = .01
var DefaultWordDelay = .2
var bSpedUp = false

func _init():
	visible = false
	Game.connect("SendDialogue", Callable(self, "OnSendDialogue"))
	DayTime.connect("Increment", Callable(self, "OnTimeIncrement"))

func OnTimeIncrement():
	if DayTime.CurrentTime != 0:
		$TimeUseClick.play()

func OnSendDialogue(data):
	SetDialogue(data)

func _ready():
	DescriptionText.visible_characters = 0
	DescriptionText.text = ""

func SplitString(s: String):
	var result = []
	s = s.strip_edges()
	var splitString = s.split("\n")
	for split in splitString:
		if len(split) >= 100:
			var words = split.split(" ")
			var sentence = ""
			for word in words:
				if len(sentence) + len(word) < 100:
					sentence += word + " "
				else:
					result.append(sentence)
					sentence = word + " "
			if sentence != "":
				result.append(sentence)
		else:
			result.append(split)
	return result

func DeleteOptions():
	for child in $VBoxContainer.get_children():
		child.queue_free()

func SetDialogue(data):
	DeleteOptions()
	Game.BroadcastEnterDialogue()
	DialogueData = data

	$TextureRect.visible = false
	$AnimationPlayer.stop()
	visible = true

	DialogueToSay = SplitString(data["Description"].Get())
	if data["Description"].GetAudio():
		$SFX.stream = data["Description"].GetAudio()
		$SFX.play()
	data["Description"].SetValue()

	if data.has("Cadence"):
		$Timer.wait_time = data["Cadence"]
	else:
		$Timer.wait_time = DefaultCharacterDelay
	StartText()

func StartText():

	$TextureRect.visible = false
	DescriptionText.visible_characters = 0
	if DialogueData["Speaker"]:
		TitleText.text = DialogueData["Speaker"].Get()
		$Panel/Panel.self_modulate = DialogueData["Speaker"].GetColor()
		$Panel/Panel.visible = true
		$TalkSound.stream = DialogueData["Speaker"].GetSound()
	else:
		$Panel/Panel.visible = false
		$TalkSound.stream = load("res://Audio/SFX/Blip_Select2.wav")
	DescriptionText.text = DialogueToSay[0]
	$Timer.wait_time = DefaultCharacterDelay
	$Timer.start()
	bSpedUp = false


func _input(event):
	if DialogueData == {} or DialogueToSay.is_empty():
		return

	if event.is_action_released("B"):
		if DescriptionText.visible_characters != len(DialogueToSay[0]):
			DescriptionText.visible_characters = len(DialogueToSay[0])
			_on_timer_timeout()
			$Timer.wait_time = DefaultCharacterDelay

	if event.is_action_released("A"):
		if IsLineFinished():
			if CanGetNextLine():
				$Timer.wait_time = DefaultCharacterDelay
				$Timer.start()
				StartText()
			else:
				if HasOptions():
					PopulateOptions()
				else:
					CloseDialogue()
	elif event.is_action_pressed("A"):
		if $Timer.wait_time != .00005:
			$Timer.wait_time = .00005
			$Timer.start()
			bSpedUp = true

func HasOptions():
	return DialogueData["Description"].HasOptions()

func PopulateOptions():
	for option in DialogueData["Description"].GetOptions():
		if option.IsOptionValid():
			var instance = load("res://Prefabs/UI/OptionButton.tscn").instantiate()
			instance.SetDialogue(option.GetOptionName(), option.GetDialogueItem(), DialogueData["Speaker"], DialogueData["Owner"])
			instance.connect("OptionClicked", Callable(self, "OnOptionClicked"))
			$VBoxContainer.add_child(instance)

	$TextureRect.visible = false

	if $VBoxContainer.get_child_count() <= 0:
		CloseDialogue()
	else:
		$VBoxContainer.get_child(0).grab_focus()

func OnOptionClicked():
	$OptionClick.play()

func CloseDialogue():

	visible = false
	if DialogueData:
		if DialogueData.has("Owner"):
			if is_instance_valid(DialogueData["Owner"]):
				DialogueData["Owner"].bCanInteract = true
	Game.BroadcastExitDialogue()

func _on_timer_timeout():
	DescriptionText.visible_characters += 1
	if bSpedUp == false:
		var index = DescriptionText.visible_characters - 1
		if len(DescriptionText.text) > index:
			if DescriptionText.text[index] == ' ':
				$Timer.wait_time = DefaultWordDelay

			else:
				$Timer.wait_time = DefaultCharacterDelay

	if DialogueData["Speaker"]:
		$TalkSound.pitch_scale = DialogueData["Speaker"].GetPitch()
	else:
		$TalkSound.pitch_scale = randf_range(1, 1.2)

	if IsLineFinished():
		$Timer.stop()
		$TextureRect.visible = true
		$AnimationPlayer.play("animateArrow")
	else:
		$TalkSound.play()

func IsLineFinished():
	return DescriptionText.visible_characters >= len(DialogueToSay[0])

func CanGetNextLine():
	DialogueToSay.pop_front()
	if DialogueToSay.is_empty():
		return false
	return true
