extends Node


var DayTimeMusicIndex = 0

var TradingMusicTrack = "res://Audio/Music/Righteous.mp3"
var DaytimeMusicTracks = [
	"res://Audio/Music/Early_Bird_Unfinished.mp3",
	"res://Audio/Music/Training_Vid.mp3"
]
var CurrentMusic = ""

func Reset():
	DayTimeMusicIndex = 0

func DetermineDayTimeMusic():
	CurrentMusic = DaytimeMusicTracks[DayTimeMusicIndex]
	DayTimeMusicIndex+= 1
	if DayTimeMusicIndex >= len(DaytimeMusicTracks):
		DayTimeMusicIndex = 0
	return CurrentMusic
