extends CharacterBody2D

var speed = 40

var bCanMove = true

func _ready():
	Game.connect("EnterDialogue", Callable(self, "OnEnterDialogue"))
	Game.connect("ExitDialogue", Callable(self, "OnExitDialogue"))

func OnEnterDialogue():
	bCanMove = false

func OnExitDialogue():
	bCanMove = true

func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if bCanMove == false:
		return
	get_input()
	var collision = move_and_collide(velocity * delta)
