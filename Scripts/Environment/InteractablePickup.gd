extends Interactable

@export var SetVariable = ""

func OnUsed():
	Game.SetData(SetVariable, true)
	queue_free()

func _input(event):
	super._input(event)


func _on_body_entered(body):
	bCanInteract = true

func _on_body_exited(body):
	bCanInteract = false
