extends Button

var DialogueToContinueTo
var Speaker
var OwningActor

func SetDialogue(option, dialogueToContinueto, speaker, owningActor):
	text = option
	DialogueToContinueTo = dialogueToContinueto
	Speaker = speaker
	OwningActor = owningActor



func _on_button_down():
		Game.BroadcastSendDialogue({
		"Speaker" : Speaker,
		"Description" : DialogueToContinueTo,
		"Owner" : OwningActor
	})
