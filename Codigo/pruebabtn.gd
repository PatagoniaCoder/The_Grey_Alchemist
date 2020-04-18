extends Node2D

var nav
var position
var path=[]
var kine

func _ready():
	set_fixed_process(true)
	nav=get_node("Navigation2D")
	position=get_node("Position2D")
	kine=get_node("KinematicBody2D")
	set_path()
	pass
func _fixed_process(delta):
	if(path.size()>1):
		var d = kine.get_pos().distance_to(path[0])
		if(d>2):
			kine.set_pos(kine.get_pos().linear_interpolate(path[0],(50*delta)/d))
		else:
			path.remove(0)
	pass
func set_path():
	path=nav.get_simple_path(get_node("KinematicBody2D").get_pos(),position.get_pos(),false)