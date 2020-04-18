extends KinematicBody2D
###VARIABLES###
var speed=224 ##Velocidad de movimiento
var inventario=[5] ##Tamaño de inventario
var selected=false ##Variable para confirmar si esta seleccionado el PJ
var direccion=Vector2() ##Vector de direccion para moverse
var lado##Determina para que lado esta mirando el chibi(utilizado para el anim de caminar)
var pos=Vector2() ##Posicion del chibi
var chibi##Numero de frame del SpriteSheet para el chibi
signal clickeado ## señal para identificar si lo cliquearon
###ATRIBUTOS###
var fuer
var dest
var cons
var inte
###FIN ATRIBUTOS###

func animacion(lado):
	if(!get_node("AnimationPlayer").is_playing()):
		get_node("AnimationPlayer").play(lado)
		
	pass

## Si el chibi fue clikeado emite la señal y se envia a si mismo
func _on_Area2D_input_event( viewport, event, shape_idx ):
	if(event.type==InputEvent.MOUSE_BUTTON&&Input.is_mouse_button_pressed(1)):
		emit_signal("clickeado",self)
	get_tree().set_input_as_handled()
