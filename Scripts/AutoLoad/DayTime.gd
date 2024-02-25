extends Node

var CurrentTime = 0
var MaxTime = 8
var Slices = 6
var Increments = 0

var Day = 0

signal ShiftOver
signal DayIncrease
signal Increment

func _ready():
	Increments = float(MaxTime / Slices)

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
