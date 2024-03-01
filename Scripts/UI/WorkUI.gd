extends Panel

@export var NoMoneyDialogue : DialogueItem
@export var MinimumMoneyDialogue:  DialogueItem
@export var RegularMoneyDialogue : DialogueItem
@export var MaxMoneyDialogue: DialogueItem
@export var FinalDayMoneyDialogue : DialogueItem

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
	FadeScreen.FadeIn()
	await get_tree().create_timer(.8).timeout
	ShowBoss(true)
	Game.TeleportPlayer("JobMovePoint")
	await get_tree().create_timer(1.0).timeout

	FadeScreen.FadeOut()


	var content = null
	if DayTime.IsLastDay():
		content = FinalDayMoneyDialogue
		PlayerInventory.AddMoney(100)
	else:
		if PlayerInventory.WorkLevel == Definitions.WorkPoor:
			content = NoMoneyDialogue
		elif PlayerInventory.WorkLevel == Definitions.WorkMinimal:
			content = MinimumMoneyDialogue
			PlayerInventory.AddMoney(10)
		elif PlayerInventory.WorkLevel == Definitions.WorkGreat:
			content = RegularMoneyDialogue
			PlayerInventory.AddMoney(25)
		else:
			content = MaxMoneyDialogue
			PlayerInventory.AddMoney(50)

	Game.BroadcastSendDialogue({
		"Speaker" : Speaker,
		"Description" : content,
	})
	Game.connect("ExitDialogue", Callable(self, "OnFinishTalking"))

func OnFinishTalking():
	print("dialogue completed")
	Game.disconnect("ExitDialogue", Callable(self, "OnFinishTalking"))
	Game.connect("ExitDialogue", Callable(self, "OnFinishTradeDialogue"))
	FadeScreen.FadeIn()
	Game.BroadcastSendDialogue({
		"Speaker" : load("res://Content/Characters/CHAR_Narrator.tres"),
		"Description" : TransitionDialogues[DayTime.Day - 1],
	})


func OnFinishTradeDialogue():
	Game.DoTrading()
	Game.disconnect("ExitDialogue", Callable(self, "OnFinishTradeDialogue"))
	await get_tree().create_timer(.8).timeout
	ShowBoss(false)

