extends Area2D

@export var Speaker : DialogueOwner
@export var Dialogue : DialogueItem

@export var bDestroyAfterDialogue = true

func _on_body_entered(body):
	Game.BroadcastSendDialogue({
			"Speaker" : Speaker,
			"Description" : Dialogue,
			"Owner" : null
		})
	if bDestroyAfterDialogue:
		queue_free()
