extends Node


var DayTimeMusicIndex = 0

var TradingMusicTrack = "res://Audio/Music/Righteous.mp3"
var DaytimeMusicTracks = [
	"res://Audio/Music/EarlyBird.mp3",
	"res://Audio/Music/PunchingIn.mp3",
	"res://Audio/Music/TrainingVid.mp3"
]
var CurrentMusic = ""

var MusicChannel = null
var MusicTimer = null

func _ready():
	MusicChannel = AudioStreamPlayer.new()
	add_child(MusicChannel)
	MusicChannel.connect("finished", Callable(self, "OnMusicFinished"))

	MusicTimer = Timer.new()
	MusicTimer.wait_time = 10
	MusicTimer.one_shot = true
	MusicChannel.volume_db = -20
	add_child(MusicTimer)
	MusicTimer.connect("timeout", Callable(self, "OnMusicTimerTimeout"))

	DayTime.connect("ShiftOver", Callable(self, "OnShiftOver"))
	DayTime.connect("DayIncrease", Callable(self, "OnDayIncrease"))

	Game.connect("StartTrading", Callable(self, "OnStartTrading"))
	Game.connect("GameWin", Callable(self, "OnGameWin"))
	Game.connect("GameLose", Callable(self, "OnGameLose"))
	Game.connect("StartPrequel", Callable(self, "OnGameStartPrequel"))

func OnMusicFinished():
	MusicTimer.start()

func OnMusicTimerTimeout():
	MusicChannel.play()

func Reset():
	DayTimeMusicIndex = 0

func DetermineDayTimeMusic():
	CurrentMusic = DaytimeMusicTracks[DayTimeMusicIndex]
	DayTimeMusicIndex+= 1
	if DayTimeMusicIndex >= len(DaytimeMusicTracks):
		DayTimeMusicIndex = 0
	return CurrentMusic

func StopMusic():
	MusicChannel.stop()
	MusicChannel.stop()

func OnShiftOver():
	StopMusic()

func OnStartTrading():
	SetMusic(MusicPlayer.TradingMusicTrack)

func OnDayIncrease():
	MusicChannel.stream = load(MusicPlayer.DetermineDayTimeMusic())
	MusicChannel.play()

func SetMusic(musicRes):
	MusicChannel.stream = load(musicRes)
	MusicChannel.play()
	MusicTimer.stop()

func OnGameWin():
	StopMusic()

func OnGameLose():
	StopMusic()

func OnGameStartPrequel():
	StopMusic()
