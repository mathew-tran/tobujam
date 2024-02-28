extends Panel

@export var NoMoneyDialogue : DialogueItem
@export var MinimumMoneyDialogue:  DialogueItem
@export var RegularMoneyDialogue : DialogueItem
@export var MaxMoneyDialogue: DialogueItem
@export var Speaker : DialogueOwner

@export var TransitionDialogues : Array[DialogueItem]

func _ready():
	DayTime.connect("ShiftOver", Callable(self, "OnShiftOver"))

func OnShiftOver():
	if Game.bIsInDialogue:
		Game.connect("ExitDialogue", Callable(self, "OnExitDialogue"))
	else:
		GivePlayerReward()

func OnExitDialogue():
	Game.disconnect("ExitDialogue", Callable(self, "OnExitDialogue"))
	GivePlayerReward()

func ShowBoss(bShow):
	var result = get_tree().get_nodes_in_group("Boss")
	if result:
		result[0].visible = bShow

func GivePlayerReward():
	Game.bBlockDialogue = true
	Game.BroadcastFadeIn()
	await get_tree().create_timer(.8).timeout
	ShowBoss(true)
	Game.TeleportPlayer("JobMovePoint")
	await get_tree().create_timer(1.0).timeout

	Game.BroadcastFadeOut()


	var content = null
	if Game.WorkLevel == 0:
		content = NoMoneyDialogue
	elif Game.WorkLevel == 1:
		content = MinimumMoneyDialogue
		Game.AddMoney(10)
	elif Game.WorkLevel == 2:
		content = RegularMoneyDialogue
		Game.AddMoney(25)
	else:
		content = MaxMoneyDialogue
		Game.AddMoney(50)

	Game.BroadcastSendDialogue({
		"Speaker" : Speaker,
		"Description" : content,
	})
	Game.connect("ExitDialogue", Callable(self, "OnFinishTalking"))

func OnFinishTalking():
	print("dialogue completed")
	Game.disconnect("ExitDialogue", Callable(self, "OnFinishTalking"))
	Game.connect("ExitDialogue", Callable(self, "OnFinishTradeDialogue"))
	Game.BroadcastFadeIn()
	Game.BroadcastSendDialogue({
		"Speaker" : load("res://Content/Characters/CHAR_Narrator.tres"),
		"Description" : TransitionDialogues[DayTime.Day - 1],
	})


func OnFinishTradeDialogue():
	Game.DoTrading()
	Game.disconnect("ExitDialogue", Callable(self, "OnFinishTradeDialogue"))
	await get_tree().create_timer(.8).timeout
	ShowBoss(false)

