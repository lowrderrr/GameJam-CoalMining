extends Node


var level = 0
var minCoal = 60 #Spawn of the coal
var timerLevel = 600

#Coal Quota
var quota = 20

#The coal you have collected no way for the player
var coal_collected = 0

#player stats
var coinsTotal = 0 #For now
var addedMining = 0
var addedSpeed = 0
var addedLight = 0
#Max you can buy
var boughtMining = 0
var boughtSpeed = 0
var boughtLight = 0


func reset():
	level = 0
	minCoal = 60
	timerLevel = 600
	quota = 20
	coal_collected = 0
	
	coinsTotal = 0
	addedMining = 0
	addedSpeed = 0
	addedLight = 0
	
	boughtMining = 0
	boughtSpeed = 0
	boughtLight = 0
	
func end_level():
	coal_collected = 0
	level += 1
