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

var jigglecheck = 1 #set to 0 if rotation jiggles

var a = 0
var b = 0
var c = 0

func _physics_process(delta):

	#for rotation, if b is higher and lower than a and c, a jiggle happened. 
	#temporarily disable player control and let the solver handle it. 
	var a = b
	var b = c
	var c = rotation
	if (b>a and b>c) or (b<a and b<c):
		jigglecheck = 0
	else:
		jigglecheck = 1
	
	#when a collision happens, a miniscule repulsive force is applied.
	if collided:
		apply_force(-.2 * linear_velocity)

	#gets the vector between the current position and current mouse position.
	#prevmousepos = mousepos
	mousepos = get_global_mouse_position()
	tovector = mousepos - position
	#normalizedtovector = tovector.normalized()

	#this marks something as selected as long as hovered once and mouse was held down.
	if (Input.is_action_pressed("click")):#held down first frame
		if (firstframe and hovered):
			selected = true
			firstframe = false
			print_debug(name)
		if (selected):
			apply_force((tovector * sensitivity * jigglecheck), Vector2(0,0)) #if necessary, subtract linear_velocity to damp.
	else:
		apply_force(-.1 * linear_velocity)
		firstframe = true
		selected = false

#all functions underneath are for input only

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
