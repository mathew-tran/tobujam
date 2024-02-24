extends Node

signal EnterDialogue
signal ExitDialogue
signal SendDialogue(data)

var GridSize = Vector2(10, 10)

signal DataUpdate


var Data = {
}

func GetData():
	return Data

func SetData(property, value):
	Data[property] = value
	emit_signal("DataUpdate")

func GetProperty(property):
	if Data.has(property):
		return str(Data[property])
	else:
		return "null"

func BroadcastSendDialogue(data):
	emit_signal("SendDialogue", data)

func BroadcastEnterDialogue():
	emit_signal("EnterDialogue")

func BroadcastExitDialogue():
	emit_signal("ExitDialogue")

