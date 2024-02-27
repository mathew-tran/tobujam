extends Area2D
class_name Interactable

@export var InteractableName : DialogueOwner
@export var InteractableContent : DialogueItem
@export var GameSetUpdate : Array[DialogueListener]

var bCanInteract = false
@export var  bIncreaseWorkLevel = false

func _ready():
	Game.connect("DataUpdate", Callable(self, "OnGameDataUpdate"))

func OnGameDataUpdate():
	for update in GameSetUpdate:
		if update.ShouldSwitch():
			InteractableContent = update.DialogueToPointTo
			GameSetUpdate = []
			break
	pass

func DisconnectUpdateCheck():
	Game.disconnect("DataUpdate", Callable(self, "OnGameDataUpdate"))

func _input(event):
	if bCanInteract and Game.CanEnterDialogue():
		if event.is_action_pressed("A"):
			Game.BroadcastSendDialogue({
				"Speaker" : InteractableName,
				"Description" : InteractableContent,
				"Owner" : self
			})
			bCanInteract = false
			OnUsed()
			DayTime.IncrementTime()
			if bIncreaseWorkLevel:
				Game.IncreaseWorkLevel()
				bIncreaseWorkLevel = false

func OnUsed():
	pass

func _on_body_entered(body):
	bCanInteract = true

func _on_body_exited(body):
	bCanInteract = false
