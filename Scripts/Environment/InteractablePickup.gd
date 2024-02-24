extends Interactable

@export var SetVariable : CustomVariable

func OnUsed():
	Game.SetData(SetVariable.GetName(), true)
	queue_free()

func _input(event):
	super._input(event)


func _on_body_entered(body):
	bCanInteract = true

func _on_body_exited(body):
	bCanInteract = false
