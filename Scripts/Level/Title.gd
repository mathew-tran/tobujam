extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	FadeScreen.FadeOut()
	MusicPlayer.SetMusic(MusicPlayer.TradingMusicTrack)
	$AnimationPlayer.play("animate")
	$TitleAnim.play("titleAnim")
