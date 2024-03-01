extends Node

var CurrentTime = 0
var MaxTime = 8
var Slices = Definitions.TimePoints
var Increments = 0

var Day = 0

signal ShiftOver
signal DayIncrease
signal Increment

func _ready():
	Increments = float(float(MaxTime) / float(Slices))

func GetDayString():
	if Day == 1:
		return "MONDAY"
	elif Day == 2:
		return "TUESDAY"
	elif Day == 3:
		return "WEDNESDAY"
	elif Day == 4:
		return "THURSDAY"
	elif Day == 5:
		return "FRIDAY"

func HardReset():
	CurrentTime = 0
	Day = 0

func Reset():
	CurrentTime = 0
	emit_signal("Increment")

func MoveNextDay():
	Reset()
	Day += 1
	emit_signal("DayIncrease")


func IncrementTime():
	CurrentTime += Increments
	if CurrentTime >= MaxTime:
		emit_signal("ShiftOver")
	emit_signal("Increment")

func IsLastDay():
	return Day >= Definitions.FinalDayGoal - 1
