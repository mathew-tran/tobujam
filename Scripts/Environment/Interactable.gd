extends Area2D
class_name Interactable

@export var InteractableName : DialogueOwner
@export var InteractableContent : DialogueItem
@export var GameSetUpdate : Array[DialogueListener]

var bCanInteract = false
@export var  bIncreaseWorkLevel = false
@export var bIncreaseTime = true

func _ready():
	PlayerInventory.connect("DataUpdate", Callable(self, "OnGameDataUpdate"))

func OnGameDataUpdate():
	for update in GameSetUpdate:
		if update.ShouldSwitch():
			InteractableContent = update.DialogueToPointTo
			GameSetUpdate = []
			break
	pass

func DisconnectUpdateCheck():
	PlayerInventory.disconnect("DataUpdate", Callable(self, "OnGameDataUpdate"))

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
			if bIncreaseTime:
				DayTime.IncrementTime()
			if bIncreaseWorkLevel:
				PlayerInventory.IncreaseWorkLevel()
				bIncreaseWorkLevel = false

func OnUsed():
	pass

func _on_body_entered(_body):
	bCanInteract = true

func _on_body_exited(_body):
	bCanInteract = false
