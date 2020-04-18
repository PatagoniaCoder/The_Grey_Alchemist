extends Node
var personaje = KinematicBody2D.new()
var pos=Vector2()
var dire={"up":Vector2(0,-24),"down":Vector2(0,24),
	"right":Vector2(24,0),"left":Vector2(-24,0)}

func ejecutar(personaje):
	pos=personaje.get_pos()
	if Input.action_press("ui_up"):
		personaje.move(pos+dire.up)
	if Input.action_press("ui_down"):
		personaje.move(pos+dire.down)
	if Input.action_press("ui_right"):
		personaje.move(pos+dire.right)
	if Input.action_press("ui_left"):
		personaje.move(pos+dire.left)
	