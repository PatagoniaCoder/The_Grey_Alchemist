extends Node
var tarjet
var lado=""
var pos=Vector2()
var midelta
var dire={"up":Vector2(0,-24),"down":Vector2(0,24),
	"right":Vector2(24,0),"left":Vector2(-24,0)}
var direccion=Vector2()
func _ready():
	set_process_input(true)
	
	pass

func _input(event):
	###MOVER PJ CON TECLAS###
	if event.type==InputEvent.KEY && tarjet:
		#pos=tarjet.get_pos()
		if event.is_action("ui_up"):
			lado="PJ_Walk_Up"
			mover(dire.up)
			get_tree().set_input_as_handled()
		if event.is_action("ui_down"):
			lado="PJ_Walk_Down"
			mover(dire.down)
			get_tree().set_input_as_handled()
		if event.is_action("ui_right"):
			lado="PJ_Walk_Right"
			mover(dire.right)
			get_tree().set_input_as_handled()
		if event.is_action("ui_left"):
			lado="PJ_Walk_Letf"
			mover(dire.left)
			get_tree().set_input_as_handled()
	###FIN MOVER PJ CON TECLAS###
func mover(value):
	direccion=value
	set_fixed_process(true)

	pass
func _fixed_process(delta):
	pos= direccion*tarjet.speed*delta
	tarjet.animacion(lado)
	tarjet.move(pos)
	set_fixed_process(false)
	
