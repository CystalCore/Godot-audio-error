extends Node2D

onready var spectrum = AudioServer.get_bus_effect_instance(1, 0)

#onready var anim = $Char

onready var eyes = $base/eyes
onready var mouth = $helm
onready var ears = $base

var definition = 6
var total_w = 1280
var total_h = 720
var min_freq = 20
var max_freq = 2000

var max_db = -15
var min_db = -60

var accel = 20
var histogram = []

var thresh = .45

func _ready():
	max_db += get_parent().volume_db
	min_db += get_parent().volume_db
	
	for i in range(definition):
		histogram.append(0)

func _process(delta):
	make_EQ(delta)
	for i in definition:
		mouth.set_mouth(i,histogram[i])
		ears.set_keys(i,histogram[i])
	png_talk()

func make_EQ(delta):
	var freq = min_freq
	var interval = (max_freq - min_freq) / definition
	
	for i in range(definition):
		
		var freqrange_low = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_low = freqrange_low #* freqrange_low * freqrange_low * freqrange_low
		freqrange_low = lerp(min_freq, max_freq, freqrange_low)
		
		freq += interval
		
		var freqrange_high = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_high = freqrange_high #* freqrange_high * freqrange_high * freqrange_high
		freqrange_high = lerp(min_freq, max_freq, freqrange_high)
		
		var mag = spectrum.get_magnitude_for_frequency_range(freqrange_low, freqrange_high)
		mag = linear2db(mag.length())
		mag = (mag - min_db) / (max_db - min_db)
		
		mag += 0.3 * (freq - min_freq) / (max_freq - min_freq)
		mag = clamp(mag, 0.01, 1)
		
		histogram[i] = lerp(histogram[i], mag, accel * delta)
	
	update()
	

func _draw():
	var draw_pos = Vector2(0, 0)
	var w_interval = total_w / definition
	
	#draw_line(Vector2(0, -total_h), Vector2(total_w, -total_h), Color.red, 2.0, true)
	
	draw_line(draw_pos, draw_pos + Vector2(0, -histogram[0] * total_h), Color.white, 10.0, true)
	
	
	

func png_talk():
	eyes.value = histogram[0] * 100
	
	
	
	
	if histogram[0] >= thresh:
		pass
		#anim.animation = "default_talk"
	else:
		pass
		#anim.animation = "default_quite"

