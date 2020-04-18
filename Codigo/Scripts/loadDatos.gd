extends Node
const PATH_FILE="res://GUI/Personajes.json"
var file=File.new()
var datos={}

func openFile():
	if not file.file_exists(PATH_FILE):
		return
	file.open(PATH_FILE,file.READ)
	datos.parse_json(file.get_as_text())
	return datos