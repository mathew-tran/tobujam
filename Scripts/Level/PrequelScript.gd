extends Node2D

@export var Speaker : DialogueOwner
@export var Content : DialogueItem

func _ready():
	$AnimationPlayer.play("dancing")
	$Brother.play("moveleft")
	Game.connect("ExitDialogue",Callable(self, "OnExitDialogue"))
	Game.BroadcastSendDialogue({
		"Speaker" : Speaker,
		"Description" : Content,
		"Owner" : null
	})

func OnExitDialogue():
	DayTime.MoveNextDay()
	FadeScreen.TransitionLevel("res://Scenes/Day1.tscn")


