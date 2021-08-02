extends Sprite


onready var keys1 = $keys1
onready var keys2 = $keys2
onready var keys3 = $keys3
onready var keys4 = $keys4
onready var keys5 = $keys5
onready var keys6 = $keys6
onready var keys7 = $keys7
onready var keys8 = $keys8

var change1 = 0
var change2 = 0
var change3 = 0
var change4 = 0

var max_h = 64


func _ready():
	update()

func set_keys(num, change):
	
	if num == 2:
		change1 = change 
	
	if num == 3:
		change2 = change
	
	if num == 4:
		change3 = change 
	
	if num == 5:
		change4 = change 
	
	update()

func _draw():
	draw_line(keys1.position, keys1.position - Vector2(0, max_h * change1), Color.green, 16, true)
	draw_line(keys2.position, keys2.position - Vector2(0, max_h * change2) , Color.green, 16, true)
	draw_line(keys3.position, keys3.position + Vector2(0, max_h * change3), Color.green, 16, true)
	draw_line(keys4.position, keys4.position + Vector2(0, max_h * change4), Color.green, 16, true)
	draw_line(keys5.position, keys5.position + Vector2(0, max_h * change4), Color.green, 16, true)
	draw_line(keys6.position, keys6.position + Vector2(0, max_h * change3), Color.green, 16, true)
	draw_line(keys7.position, keys7.position - Vector2(0, max_h * change2), Color.green, 16, true)
	draw_line(keys8.position, keys8.position - Vector2(0, max_h * change1), Color.green, 16, true)
	
