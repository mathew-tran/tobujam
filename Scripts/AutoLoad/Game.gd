extends Node

signal EnterDialogue
signal ExitDialogue
signal SendDialogue(data)

var GridSize = Vector2(10, 10)

signal DataUpdate
signal WorkUpdate

var Data = {
}

var WorkLevel = 0
var Money = 50
signal MoneyUpdate

var bIsInDialogue = false

func MoveToNextDay():
	ResetWork()
	DayTime.MoveNextDay()
	Game.TeleportPlayer("StartPoint")

func AddMoney(amount):
	Money += amount
	emit_signal("MoneyUpdate")

func IncreaseWorkLevel():
	WorkLevel += 1
	emit_signal("WorkUpdate")

func ResetWork():
	WorkLevel = 0
	emit_signal("WorkUpdate")

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
	bIsInDialogue = true

func BroadcastExitDialogue():
	emit_signal("ExitDialogue")
	bIsInDialogue = false

func TeleportPlayer(pointName):
	var movePoints = get_tree().get_nodes_in_group("MovePoint")
	for point in movePoints:
		if point.name == pointName:
			point.MovePlayer()
