extends Node

const PATH_FILE="res://GUI/PartySelected.json"
var file=File.new()

func saveFile(datos):
	
	file.open(PATH_FILE,file.WRITE)
	file.store_line(datos.to_json())
	file.close()
	