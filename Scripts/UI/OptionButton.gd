extends Button

var DialogueToContinueTo
var Speaker
var OwningActor

signal OptionClicked

func SetDialogue(option, dialogueToContinueto, speaker, owningActor):
	text = option
	DialogueToContinueTo = dialogueToContinueto
	Speaker = speaker
	OwningActor = owningActor



func _on_button_down():
	emit_signal("OptionClicked")
	Game.BroadcastSendDialogue({
		"Speaker" : Speaker,
		"Description" : DialogueToContinueTo,
		"Owner" : OwningActor
	})
