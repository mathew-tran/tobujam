extends Node

signal EnterDialogue
signal ExitDialogue
signal SendDialogue(data)
signal GameWin
signal GameLose
signal StartPrequel

var GridSize = Vector2(10, 10)

var bIsInDialogue = false
var bBlockDialogue =false

var Stocks = {}

signal StartTrading



func _ready():
	pass

func HardReset():
	emit_signal("StartPrequel")
	PlayerInventory.Reset()
	MusicPlayer.Reset()
	bBlockDialogue = false

func DoTrading():
	bBlockDialogue = true

	await get_tree().create_timer(.8).timeout
	emit_signal("StartTrading")


	var result = get_tree().get_nodes_in_group("StockUI")
	if result:
		result[0].visible = true


func MoveToNextDay():
	PlayerInventory.ResetWork()
	if PlayerInventory.GetTotalAssets() >= Definitions.TotalAssetGoal:
		emit_signal("GameWin")
		FadeScreen.TransitionLevel("res://Scenes/GameWin.tscn")
		return
	if DayTime.Day + 1 >= Definitions.FinalDayGoal:
		emit_signal("GameLose")
		FadeScreen.TransitionLevel("res://Scenes/GameLose.tscn")
		return
	var NextDayScene = "res://Scenes/Day" + str(DayTime.Day + 1) + ".tscn"

	FadeScreen.TransitionLevel(NextDayScene)
	DayTime.MoveNextDay()
	bBlockDialogue = false


func CanEnterDialogue():
	return bIsInDialogue == false and bBlockDialogue == false

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


