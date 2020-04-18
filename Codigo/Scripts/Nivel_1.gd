extends Node
const PATH_FILE="res://GUI/PartySelected.json"
var fileDatos=File.new() ## Archivo de la party seleccionada
var datosPJ={} ## Diccionario para ordenar los datos de la party
var currentChibi=null ## Variable para almacenar los pj seleccionados
var previoChibi=null ## Variable para almacenar los pj seleccionados
var currenPos=Vector2() ## Posicion inicial de chibi
var objetivo=Vector2() ## posicion del click
var path=Vector2Array() ## camino para navegar
var cambas=false
onready var nav=get_node("Navigation2D")
func _ready():
	set_process_input(true)
	fileDatos.open(PATH_FILE,fileDatos.READ)
	datosPJ.parse_json(fileDatos.get_as_text())
	currenPos=Vector2(150,320)
	## Se instancian las escenas deacuerdo al total
	## de PJs en la party
	var dir="res://Personajes/PJ%s/Personaje%s.tscn" ## "%s"=variable que 
	## se completa abajo con el numero de pj
	for i in datosPJ:
		var x=int(i)+1 ## incrementa en uno para no poner 0 (ya que no hay)
		var pj1=load(dir % [x,x]).instance()
		pj1.set_pos(currenPos) ##posicion inicial de los pjs
		currenPos+=Vector2(48,0)
		pj1.connect("clickeado",self,"_on_clickeado") ## Conecta 
		## las señales de todos los pj
		var btn=TouchScreenButton.new()
		btn.set_texture(pj1.retrato)
		btn.set_texture_pressed(pj1.retrato)
		btn.set_scale(Vector2(0.25,0.25))
		get_node("CanvasLayer/GridContainer").add_child(btn)
		btn.set_opacity(0.5)
		btn.connect("pressed",self,"_on_Retrato_focus_enter",[btn])
#		btn.connect("focus_exit",self,"_on_Retrato_focus_exit",[btn])
		add_child(pj1)
	pass

func _on_clickeado(chibi):
	path=Vector2Array() # --> cada vez que se selecciona un chibi se
						# se resetea el path
	cambas=false
	var retratos = get_node("CanvasLayer/GridContainer").get_children()
	for i in retratos:
		i.set_opacity(1.0)
	## se comprueba si existe un chibi en la variable, y si no, la agrega
	## junto con el previo ya que el current y el previo son el mismo
	## y establece el atributo selected en true
	## instancia la interface correspondiente al pj y la agrega al pj
	if currentChibi==null: 
		currentChibi=chibi
		previoChibi=chibi
		currentChibi.selected=true
		
		var gui = load("res://GUI/Interface_Combate/SeleccionPJ.tscn").instance()
		gui.getPJ(currentChibi)
		currentChibi.get_node("cuadroSeleccion").show()
		currentChibi.get_node("Camera2D").make_current()
		currentChibi.add_child(gui)
		print("posision primer chibi: ",currentChibi.get_pos().floor())
		objetivo=currentChibi.get_pos().floor()
	## Si no es null un pj ha sido seleccionado y verifica si se esta
	## seleccionando nuevamente. Si es la primera vez actualiza las variables
	## current y previo e instancia la interface, luego agrega la misma al pj
	elif currentChibi!=chibi:
		previoChibi=currentChibi
		currentChibi=chibi
		previoChibi.selected=false
		previoChibi.get_node("cuadroSeleccion").hide()
		previoChibi.get_node("ISeleccionPJ").queue_free()
		currentChibi.selected=true
		var gui = load("res://GUI/Interface_Combate/SeleccionPJ.tscn").instance()
		currentChibi.get_node("cuadroSeleccion").show()
		gui.getPJ(currentChibi)
		
		previoChibi.get_node("Camera2D").clear_current()
		currentChibi.get_node("Camera2D").make_current()
		currentChibi.add_child(gui)
		print("posision chibi: ",currentChibi.get_pos().floor())
		objetivo=null
	## si ha sido seleccionado dos veces, elimina la interface
	else:
		currentChibi.selected=false
		currentChibi.get_node("cuadroSeleccion").hide()
		currentChibi.get_node("ISeleccionPJ").queue_free()
		currentChibi=null
		previoChibi=null

	
## guarda el path para seguir
func set_path(end_position):
	if(currentChibi!=null):
		path=nav.get_simple_path(currentChibi.get_pos(),end_position,true)
		path.remove(0)
		set_fixed_process(true)
	pass
		
func mover(distancia):
	var last_point=currentChibi.get_pos()
	
	for index in range(path.size()):
		var distance_between_points = last_point.distance_to(path[0])

		if distancia <= distance_between_points and distancia >= 0.0:
			currentChibi.set_pos(last_point.linear_interpolate(path[0], distancia / distance_between_points))
			break

		elif distancia < 0.0:
			currentChibi.set_pos(path[0])
			set_process(false)
			break
		distancia -= distance_between_points
		last_point = path[0]

		path.remove(0)
	
	
	
func _input(event):
	print(event.type==InputEvent.SCREEN_TOUCH)
	if(event.is_action_pressed("click_izq")&&!event.type==InputEvent.SCREEN_TOUCH):
		var end_position=get_local_mouse_pos()
		set_path(end_position)
	pass
func _fixed_process(delta):
	

	if(currentChibi!=null):
		var distancia = currentChibi.speed*delta
		mover(distancia)




func _on_Retrato_focus_enter(btn):
	cambas=true
	btn.set_opacity(1.0)
	pass 
func _on_Retrato_focus_exit(btn):
	cambas=true
	btn.set_opacity(0.5)

