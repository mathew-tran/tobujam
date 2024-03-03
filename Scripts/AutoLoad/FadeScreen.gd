extends CanvasLayer

func _ready():
	FadeOut()

func FadeIn():
	if $AnimationPlayer.current_animation != "FadeToBlack":
		$AnimationPlayer.play("FadeToBlack")

func FadeOut():
	if $AnimationPlayer.current_animation != "FadeOutBlack":
		$AnimationPlayer.play("FadeOutBlack")

func TransitionLevel(newScene):
	FadeIn()
	await get_tree().create_timer(.5).timeout
	get_tree().change_scene_to_file(newScene)
	FadeOut()
