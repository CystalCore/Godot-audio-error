extends Node2D

var effect
var recording
var dbs

onready var ASR = preload("res://AudioStreamRecord.tscn")


func _ready():
	#var idx = AudioServer.get_bus_index("Record")
	#effect = AudioServer.get_bus_effect(idx, 0)
	
	#$Timer.start()
	
	OS.set_window_title("PNGTuber")
	

func _process(delta):
	
	inputs()
	

func inputs():
	pass
	

func _on_Timer_timeout():
	$Timer.start()
