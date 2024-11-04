extends TextEdit

const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
const SECURITY_KEY = "©89SADFH"
const DEFAULT_ID = "test202410"

#var player_data = PlayerData.new()
#var player_data = {}

func verify_save_folder(path: String):
	DirAccess.make_dir_absolute(path)

# By default this will only read data. Pass a different access variable for modification
func get_file(path, access = FileAccess.READ):
	if path == null:
		print("get_file(): 1st argument `path` is empty.")
		return
		
	#return FileAccess.open_compressed(path, access) # not effective. if there's more data, maybe
	return FileAccess.open(path, access)
	#return FileAccess.open_encrypted_with_pass(path, access, SECURITY_KEY)

# Returns false if data could not be saved
func save_data(new_data, data_slot: String = DEFAULT_ID) -> bool:
	print('EXPERIMENTAL feature. May break.') 
	print("Saved: " + SAVE_DIR + data_slot)
	var file = get_file(SAVE_DIR + data_slot, FileAccess.WRITE)
	if file == null:
		print(FileAccess.get_open_error())
		return false

	#player_data = {
		#"player_data":{
			#"health": player_data.health,
			#"position":{
				#"x": player_data.global_position.x,
				#"y": player_data.global_position.y
			#},
			#"coins": player_data.coins
		#}
	#}
	
	#var json_string = JSON.stringify(data, "\t")
	#file.store_string(json_string)
	file.store_string(new_data)
	file.close()
	return true


func load_data(data_slot: String = DEFAULT_ID): # return change later?
	print('EXPERIMENTAL feature. May break.')
	var path = SAVE_DIR + data_slot
	print(path)
	if FileAccess.file_exists(path):
		var file = get_file(path)
		if file == null:
			print("Could not load data from " + str(path) + ". Possible error message below:")
			print(FileAccess.get_open_error())
			return

		var data = file.get_as_text()
		print(str(data) + " is real and won't hurt u")
		file.close()

		#var data = JSON.parse_string(content)
		if data == null:
			#printerr("Cannot parse %s as a json_string: (%s)" % [data_slot, content])
			printerr("Cannot parse %s: (%s)" % [data_slot, data])
			return "gameerror loading data"
		else:
			print("Loaded: " + str(data))
			return data

		# init data + defaults

func del_data(data_slot): # Dangerous! no DEFAULT ID for safe measures ... can be changed later.
	#$".".clear() # this will fire .changed() so note two file writes may occur
	print("Deleting!\n")
	DirAccess.remove_absolute(SAVE_DIR + data_slot)

	print("Reloading (after 1 second delay)")
	return load_data(data_slot)

# example functions

func _on_text_changed() -> void: # save data
	print("\nsaving text:")
	var txt = $".".text
	print(txt)
	if save_data(txt):
		print("saved data!")
	else:
		print("failed to save data!")
	#save_data(txt, "test202410")

func _on_button_pressed() -> void:
	$".".text = str(del_data("test202410"))

	print("no wayy")

func _ready(): # load data
	verify_save_folder(SAVE_DIR)
	#load_data("SAVE_DIR + SAVE_FILE_NAMErobux")
	$".".text = str(load_data()) + $".".text
