extends Control

var arrayPJ # Contiene las escenas de los PJs
var arrayPJSelec=[] ##Contiene las escenas de los PJs seleccionados
var diccParty={} ##diccionario de party seleccionada para almacenar en JSON
var index=0 # Indice del arrayPJ
var file=load("res://Scripts/loadDatos.gd").new() # Carga descripcion de PJs
var count=0 # Contador de personajes seleccionados
var maxParty=5
func _ready():
	get_node("VBoxContainer/Titulo").set_text("SELECCIONE "+str(maxParty)+" PERSONAJES")
	arrayPJ=get_tree().get_nodes_in_group("PERSONAJE")
	arrayPJ[0].get_node("ColorFrame").show() ## cuadro de seleccion de Chibi
	rellenar()
	pass


func _on_Ant_pressed():
	##Cambia el retrato del personaje y mueve el cuadro de seleccion
	if index>arrayPJ.find(arrayPJ.front()):
		arrayPJ[index].get_node("ColorFrame").hide()
		index-=1
		arrayPJ[index].get_node("ColorFrame").show()
	else:
		arrayPJ[index].get_node("ColorFrame").hide()
		index=arrayPJ.size()-1
		arrayPJ[index].get_node("ColorFrame").show()
	comprobarSeleccion()
	rellenar()
	
func _on_Seleccionar_pressed():
	if arrayPJSelec.find(arrayPJ[index])==-1&&arrayPJSelec.size()<maxParty:
		arrayPJSelec.append(arrayPJ[index])
		arrayPJ[index].get_node("AnimationPlayer").play("Selected")
		get_node("ColorFrame").show()
		sleccionParty()
	elif arrayPJSelec.find(arrayPJ[index])==-1&&arrayPJSelec.size()==maxParty:
		get_node("ParyLlena").show()
	
	elif arrayPJSelec.find(arrayPJ[index])>-1:
		arrayPJ[index].get_node("AnimationPlayer").play("Unselect")
		arrayPJSelec.erase(arrayPJ[index])
		
		sleccionParty()
	comprobarSeleccion()

	
func _on_Sig_pressed():
	##Cambia el retrato del personaje y mueve el cuadro de seleccion
	if index<arrayPJ.size()-1:
		arrayPJ[index].get_node("ColorFrame").hide()
		index+=1
		arrayPJ[index].get_node("ColorFrame").show()
	else:
		arrayPJ[index].get_node("ColorFrame").hide()
		index=0
		arrayPJ[index].get_node("ColorFrame").show()
	comprobarSeleccion()
	rellenar()


########################################################################
	##Si el personaje no esta seleccionado lo agrega al grupo de seleccion##
########################################################################
	
func rellenar():
	var x = str(index+1)
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer/ID").set_text(str(file.openFile()[x]["ID"]))
	##NOMBRE
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer/nombre").set_text(file.openFile()[x]["Nombre"])
	##EDAD
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer 2/edad").set_text(file.openFile()[x]["Edad"])
	##CLASE
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer 2/clase").set_text(file.openFile()[x]["Clase"])
	##RAZA
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer 2/raza").set_text(file.openFile()[x]["Raza"])
	##DESCRIPCION
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/HDesc/descripcion").set_bbcode(file.openFile()[x]["Descripcion"])
	
	######################################################################################################################################################
	###############Se convierten los enteros del Stat en String para la caja de texto#####################################################################
	##FUE
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Fuerza_Base").set_text(str(file.openFile()[x]["Stats"]["FUE"]))  ##
	##INT
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Inte_Base").set_text(str(file.openFile()[x]["Stats"]["INT"]))    ##
	##DES
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Agil_Base").set_text(str(file.openFile()["1"]["Stats"]["DES"]))  ##
	##CON
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Const_Base").set_text(str(file.openFile()["1"]["Stats"]["CON"])) ##
	##SUE
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Suerte_Base").set_text(str(file.openFile()["1"]["Stats"]["SUE"]))##
	######################################################################################################################################################
	######################################################################################################################################################
	## Se cargan los retratos según el pj seleccionado
	get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/Patch9Frame").set_texture(load("res://Sprite/Personajes/PJ"+x+"/retrato"+x+".png"))
	
func comprobarSeleccion():##Cambia el texto del boton seleccionar
	if arrayPJSelec.find(arrayPJ[index])>-1:
		get_node("VBoxContainer/VSplitContainer/Botones/Seleccionar").set_text("Deseleccionar")
		get_node("ColorFrame").show()
	else:
		get_node("VBoxContainer/VSplitContainer/Botones/Seleccionar").set_text("Seleccionar")
		get_node("ColorFrame").hide()

func sleccionParty():
	## agrega la party a un diccionario para luego guardarlo como JSON 
	## file, si se deselecciona un personaje lo elimina del grupo
	if diccParty.has(index):
		diccParty.erase(index)
	else:
		diccParty[index]={
	"ID":get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer/ID").get_text(),
	"Nombre":get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer/nombre").get_text(),
	"Clase":get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer 2/clase").get_text(),
	"Edad":get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer 2/edad").get_text(),
	"Raza":get_node("VBoxContainer/PanelContainer/VBoxContainer 2/GridContainer 2/raza").get_text(),
	"Stats":{
		"FUE":int(get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Fuerza_Base").get_text()),
		"CON":int(get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Const_Base").get_text()),
		"INT":int(get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Inte_Base").get_text()),
		"DES":int(get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Agil_Base").get_text()),
		"SUE":int(get_node("VBoxContainer/PanelContainer/VBoxContainer 2/HBoxContainer/GridContainer/Suerte_Base").get_text())
		},
	}
	pass

func saveData():
	##Guarda la party seleccionada en un JSON file
	var save = load("res://Scripts/SaveData.gd").new()
	save.saveFile(diccParty)
	pass


func _on_Aceptar_pressed():
	if arrayPJSelec.size()==maxParty:
		saveData()
		get_tree().change_scene_to(load("res://Niveles/Nivel_1.tscn"))
	else:
		get_node("PartyIncompleta").show()
	pass # replace with function body
