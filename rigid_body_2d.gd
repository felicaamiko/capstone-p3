extends RigidBody2D

var hovered = false
var selected = false#move to global function
var firstframe = true
var mouseoffset = Vector2(0,0)
var collided = false
var toocollided = false
var prevmousepos = Vector2(0,0)
var mousepos = Vector2(0,0)
var tovector = Vector2(0,0)

var normalizedtovector = Vector2(0,0)
var sensitivity = 1 #max is 10
var magnitude = 1
var jigglecheck = 1 #set to 0 if rotation jiggles

var a = 0
var b = 0
var c = 0
var d = 0

func _physics_process(delta):
	var a = b
	var b = c
	var c = rotation
	if (b>a and b>c) or (b<a and b<c):
		jigglecheck = 0
	else:
		jigglecheck = 1
	
	if collided:
		apply_force(-.2 * linear_velocity)
	print_debug(linear_velocity)
	prevmousepos = mousepos
	mousepos = get_global_mouse_position()
	tovector = mousepos - position
	normalizedtovector = tovector.normalized()
	if (Input.is_action_pressed("click")):#held down first frame
		if (firstframe and hovered):
			selected = true
			firstframe = false
		if (selected):
			apply_force((tovector * sensitivity * magnitude * jigglecheck)-linear_velocity, Vector2(0,0))
	else:
		apply_force(-.1 * linear_velocity)
		firstframe = true
		selected = false

func _on_outerwall_mouse_entered():
	#print_debug("entered")
	hovered = true
	
func _on_outerwall_mouse_exited():
	#print_debug("exited")
	hovered = false

func _on_outerwall_body_entered(body):
	collided = true
	#print_debug("collided")

func _on_outerwall_body_exited(body):
	collided = false
