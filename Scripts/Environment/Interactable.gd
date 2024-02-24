extends Area2D

@export var InteractableName = "name"
@export var InteractableContent = "..."

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

func _on_body_entered(body):
	bCanInteract = true

func _on_body_exited(body):
	bCanInteract = false
