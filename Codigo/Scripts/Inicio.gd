extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

## Boton de interface de inicio, se carga el primer nivel
func _on_Button_pressed():
	get_tree().change_scene_to(load("res://GUI/SeleccionParty.tscn"))
	pass # replace with function body

