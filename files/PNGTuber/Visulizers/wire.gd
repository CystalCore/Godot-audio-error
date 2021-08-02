extends Sprite

onready var pos1 = $pos1
onready var pos2 = $pos2
onready var pos3 = $pos3
onready var pos4 = $pos4
onready var pos5 = $pos5
onready var pos6 = $pos6
onready var pos7 = $pos7
onready var pos8 = $pos8

var change1 = 0
var change2 = 0
var change3 = 0
var change4 = 0
var change5 = 0
var change6 = 0

var ammount = 96

var voice = 96

func _ready():
	update()

func set_mouth(num, change):
	
	if num == 0:
		change1 = change 
	
	if num == 1:
		change2 = change
	
	if num == 2:
		change3 = change 
	
	if num == 3:
		change4 = change 
	
	if num == 4:
		change5 = change 
	
	if num == 5:
		change6 = change 
	
	update()

func _draw():
	moving_lines()
	dense_lines()

func moving_lines():
	pass

func dense_lines():
	draw_line(pos1.position, pos2.position, Color.green, ammount * .01, true)
	draw_line(pos2.position, pos3.position, Color.green, change2 * (voice/4), true)
	draw_line(pos3.position, pos4.position, Color.green, change2 * (voice/2), true)
	draw_line(pos4.position, pos5.position, Color.green, change2 * voice, true)
	draw_line(pos5.position, pos6.position, Color.green, change2 * (voice/2), true)
	draw_line(pos6.position, pos7.position, Color.green, change2 * (voice/4), true)
	draw_line(pos7.position, pos8.position, Color.green, ammount * .01, true)

