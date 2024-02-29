extends Control

var DialogueData = {}

@onready var DescriptionText = $Panel/Description
@onready var TitleText = $Panel/Panel/Speaker

var DialogueToSay = []
var DefaultCharacterDelay = .1


func _enter_tree():
	visible = false
	Game.connect("SendDialogue", Callable(self, "OnSendDialogue"))

func OnSendDialogue(data):
	SetDialogue(data)

func _ready():
	DescriptionText.visible_characters = 0
	DescriptionText.text = ""
	#SetDialogue({
		#"Speaker" : "Janitor",
		#"Description" : "Testing dialogue.... this is a long sentence with no point to it oh Testin testing testin",
		#"Cadence" : .05
	#})

func SplitString(s: String):
	var result = []
	s = s.strip_edges()
	var splitString = s.split("\n")
	for split in splitString:
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
	DescriptionText.visible_characters = 0
	if DialogueData["Speaker"]:
		TitleText.text = DialogueData["Speaker"].Get()
		$Panel/Panel.visible = true
	else:
		$Panel/Panel.visible = false
	DescriptionText.text = DialogueToSay[0]
	$Timer.wait_time = DefaultCharacterDelay
	$Timer.start()


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
	$TalkSound.pitch_scale = randf_range(1, 1.1)
	$TalkSound.play()
	if IsLineFinished():
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
