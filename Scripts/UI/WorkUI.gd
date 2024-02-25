extends Panel

@export var NoMoneyDialogue : DialogueItem
@export var MinimumMoneyDialogue:  DialogueItem
@export var RegularMoneyDialogue : DialogueItem
@export var MaxMoneyDialogue: DialogueItem
@export var Speaker : DialogueOwner
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


func GivePlayerReward():
	Game.TeleportPlayer("JobMovePoint")

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
	Game.MoveToNextDay()
	Game.disconnect("ExitDialogue", Callable(self, "OnFinishTalking"))

