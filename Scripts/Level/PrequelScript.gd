extends Node2D

@export var Speaker : DialogueOwner
@export var Content : DialogueItem

func _enter_tree():
	FadeScreen.FadeOut()

func _ready():
	Game.connect("ExitDialogue",Callable(self, "OnExitDialogue"))
	Game.BroadcastSendDialogue({
		"Speaker" : Speaker,
		"Description" : Content,
	})

func OnExitDialogue():
	DayTime.MoveNextDay()
	get_tree().change_scene_to_file("res://Scenes/Day1.tscn")
