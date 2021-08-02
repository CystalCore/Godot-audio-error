extends Node2D

onready var spectrum = AudioServer.get_bus_effect_instance(1, 1)
onready var bars = $Bars
onready var Tbar = $Bars/TekuBar

var definition = 20
var total_w = 1280
var total_h = 720
var min_freq = 20
var max_freq = 20000

var max_db = -15
var min_db = -45

var accel = 20
var histogram = []

func _ready():
	max_db += get_parent().volume_db
	min_db += get_parent().volume_db
	
	set_bars()
	
	for i in range(definition):
		histogram.append(0)
	
	

func _process(delta):
	make_EQ(delta)
	move_bars(delta)
	

func make_EQ(delta):
	var freq = min_freq
	var interval = (max_freq - min_freq) / definition
	
	for i in range(definition):
		
		var freqrange_low = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_low = freqrange_low * freqrange_low * freqrange_low * freqrange_low
		freqrange_low = lerp(min_freq, max_freq, freqrange_low)
		
		freq += interval
		
		var freqrange_high = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_high = freqrange_high * freqrange_high * freqrange_high * freqrange_high
		freqrange_high = lerp(min_freq, max_freq, freqrange_high)
		
		var mag = spectrum.get_magnitude_for_frequency_range(freqrange_low, freqrange_high)
		mag = linear2db(mag.length())
		mag = (mag - min_db) / (max_db - min_db)
		
		mag += 0.3 * (freq - min_freq) / (max_freq - min_freq)
		mag = clamp(mag, 0.01, 1)
		
		histogram[i] = lerp(histogram[i], mag, accel * delta)
	
	#update()
	

func move_bars(delta):
	
	for i in range(definition):
		bars.get_child(i).value = (histogram[i] * 100)
	

func set_bars():
	for i in range(definition):
		var pos = 64 * i
		bars.get_child(i).margin_top = pos + 6
		bars.get_child(i).margin_left = 16
