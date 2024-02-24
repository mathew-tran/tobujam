extends Node

signal EnterDialogue
signal ExitDialogue

func BroadcastEnterDialogue():
	emit_signal("EnterDialogue")

func BroadcastExitDialogue():
	emit_signal("ExitDialogue")
