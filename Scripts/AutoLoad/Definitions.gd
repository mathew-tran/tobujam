extends Node

var ColorData = {
	"brown" : "987b4e",
	"blue" : "4896cd",
	"grey" : "585b65",
	"purple" : "734f99",
	"red": "bb3330",
	"darkbrown" : "5f372c",
	"pink" : "e7ccb4",
	"orange" : "b67b2e",
	"white" : "fcfaf6",
	"black" : "13110d",
	"lightblue": "9aa5bf",
	"navyblue" : "142c4b",
	"tourquise" : "426773",
	"silver" : "91877b",
	"palegreen" : "aab69a",
	"darkgreen" : "474f2d"
}

var TimePoints = 8
var StartingCash = 100

# still need to update dialogue..
var TotalAssetGoal = 2000

var FinalDayGoal = 6

var WorkPoor = 0
var WorkMinimal = 1
var WorkGreat = 2

func GetWorkRating(amount):
	if amount == WorkPoor:
		return "POOR"
	if amount == WorkMinimal:
		return "MINIMAL"
	if amount == WorkGreat:
		return "GREAT"
	return "PERFECT"
