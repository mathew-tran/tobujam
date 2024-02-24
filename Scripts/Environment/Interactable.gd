extends Area2D
class_name Interactable

@export var InteractableName : DialogueOwner
@export var InteractableContent : DialogueItem

var bCanInteract = false

func _input(event):
	if bCanInteract:
		if event.is_action_pressed("A"):
			Game.BroadcastSendDialogue({
				"Speaker" : InteractableName,
				"Description" : InteractableContent,
				"Owner" : self
			})
			bCanInteract = false
			OnUsed()

func OnUsed():
	pass

func _on_body_entered(body):
	bCanInteract = true

func _on_body_exited(body):
	bCanInteract = false
