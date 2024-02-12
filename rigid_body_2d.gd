extends RigidBody2D

var hovered = false
var selected = false#move to global function
var firstframe = true
var mouseoffset = Vector2(0,0)

var prevmousepos = Vector2(0,0)
var mousepos = Vector2(0,0)
var tovector = Vector2(0,0)

var sensitivity = 5 #max is 10

func _ready():
	pass

func _physics_process(delta):
	prevmousepos = mousepos
	mousepos = get_global_mouse_position()
	tovector = mousepos - position
	if (Input.is_action_pressed("click")):#held down first frame
		if (firstframe and hovered):
			Global.selected = true
			firstframe = false
		if (selected):
			apply_force((tovector * sensitivity)-linear_velocity, Vector2(0,0))
			print_debug(tovector-linear_velocity)
	else:
		firstframe = true
		selected = false

func _on_area_2d_mouse_entered():
	print_debug("entered")
	hovered = true

func _on_area_2d_mouse_exited():
	#print_debug("exited")
	hovered = false
