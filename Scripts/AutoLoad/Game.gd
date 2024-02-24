extends Node

signal EnterDialogue
signal ExitDialogue
signal SendDialogue(data)

var Data = {
	"bHasWater" : false
}
func BroadcastSendDialogue(data):
	emit_signal("SendDialogue", data)

func BroadcastEnterDialogue():
	emit_signal("EnterDialogue")

func BroadcastExitDialogue():
	emit_signal("ExitDialogue")

