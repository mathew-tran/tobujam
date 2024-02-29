extends CanvasLayer

func _ready():
	FadeOut()

func FadeIn():
	$AnimationPlayer.play("FadeToBlack")

func FadeOut():
	$AnimationPlayer.play("FadeOutBlack")
