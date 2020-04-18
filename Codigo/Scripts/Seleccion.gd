extends Polygon2D
var tipo
var poli_x
var poli_y

func seleccionar(tipo):
	if tipo.is_in_group("PERSONAJE") and !tipo.has_node("ISeleccionPJ"):
		var menu = load("res://GUI/Interface_Combate/SeleccionPJ.tscn").instance()
		menu.getPJ(tipo)
		tipo.add_child(menu)
		tipo.add_child(self)
		tipo.get_node("CuadroSeleccion").set_polygon([Vector2(-24,-24),Vector2(24,-24),Vector2(24,24),Vector2(-24,24)])
		tipo.get_node("CuadroSeleccion").show()
	pass
func deseleccionar():
	if !get_tree().get_nodes_in_group("GUI").empty():
		get_node(".").hide()
		var menu=get_tree().get_nodes_in_group("GUI")
		if(!menu.empty()):
			for i in range(menu.size()):
				menu[i].queue_free()
	queue_free()