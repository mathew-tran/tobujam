extends CharacterBody2D

var speed = 80

var bCanMove = true
enum DIRECTION {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}
var Direction = DIRECTION.DOWN

func _ready():
	$CanvasLayer/BlackScreen.visible = true
	Game.connect("EnterDialogue", Callable(self, "OnEnterDialogue"))
	Game.connect("ExitDialogue", Callable(self, "OnExitDialogue"))
	DayTime.connect("ShiftOver", Callable(self, "OnShiftOver"))
	DayTime.connect("DayIncrease", Callable(self, "OnDayIncrease"))
	Game.connect("FadeIn", Callable(self, "OnFadeIn"))
	Game.connect("FadeOut", Callable(self, "OnFadeOut"))

	UpdateAnims()
	add_to_group("Player")
	Game.BroadcastFadeOut()

func OnFadeIn():
	$CanvasLayer/AnimationPlayer.play("FadeToBlack")

func OnFadeOut():
	$CanvasLayer/AnimationPlayer.play("FadeOutBlack")

func OnShiftOver():
	$Music.stop()
	$MusicTimer.stop()

func OnDayIncrease():
	$Music.play()
	Game.BroadcastFadeOut()

func OnEnterDialogue():
	bCanMove = false
	StopAnim()

func OnExitDialogue():
	bCanMove = true

func StopAnim():
	$Sprite2D.speed_scale = 0
	$Sprite2D.frame = 0
	velocity = Vector2.ZERO

func get_input():
	$Sprite2D.speed_scale =  1
	if Input.is_action_pressed("ui_left"):
		Direction = DIRECTION.LEFT
	elif Input.is_action_pressed("ui_right"):
		Direction = DIRECTION.RIGHT
	elif Input.is_action_pressed("ui_up"):
		Direction = DIRECTION.UP
	elif Input.is_action_pressed("ui_down"):
		Direction = DIRECTION.DOWN
	else:
		StopAnim()
		return

	velocity = GetInputVelocity() * speed

	UpdateAnims()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if bCanMove == false:
		return
	get_input()
	#var collision = move_and_collide(velocity * delta)
	var pos = global_position
	var result = move_and_slide()
	if pos == global_position:
		StopAnim()

func GetInputVelocity():
	if Direction == DIRECTION.LEFT:
		return Vector2(-1, 0)
	elif Direction == DIRECTION.RIGHT:
		return Vector2(1, 0)
	elif Direction == DIRECTION.UP:
		return Vector2(0, -1)
	elif Direction == DIRECTION.DOWN:
		return Vector2(0, 1)

	return Vector2.ZERO

func UpdateAnims():
	if Direction == DIRECTION.LEFT:
		$Sprite2D.scale = Vector2(1,1)
		return ChangeAnim("left")
	elif Direction == DIRECTION.RIGHT:
		$Sprite2D.scale = Vector2(-1,1)
		return ChangeAnim("left")
	elif Direction == DIRECTION.UP:
		return ChangeAnim("up")
	elif Direction == DIRECTION.DOWN:
		return ChangeAnim("down")

	return Vector2.ZERO

func ChangeAnim(newAnim):
	if $Sprite2D.animation == newAnim:
		return

	$Sprite2D.play(newAnim)
	$Sprite2D.frame += 1


func _on_music_finished():
	$MusicTimer.start()

func _on_music_timer_timeout():
	$Music.play()


func _on_animation_player_animation_finished(anim_name):
	pass
