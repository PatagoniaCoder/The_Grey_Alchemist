extends CanvasLayer


func _ready():
	
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func getPJ(tipo):
	var x=tipo.retrato.get_size().x ## cantidad de retratos en x de la imagen
	var y=tipo.retrato.get_size().y ## cantidad de retratos en y de la imagen
	
	get_node("Panel_Principal/TextureFrame").set_texture(tipo.retrato)
	get_node("Panel_Principal/TextureFrame").set_region_rect(Rect2(0,0,x,y))
	pass

func _on_Button_2_pressed():
	if(get_node("Sub_Panel_Magia").is_visible()):
		get_node("Sub_Panel_Magia").hide()
	else:	
		get_node("Sub_Panel_Magia").show()
	pass # replace with function body
