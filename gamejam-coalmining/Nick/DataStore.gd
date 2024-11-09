extends TextEdit

const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
#const SECURITY_KEY = "©89SADFH"
const DEFAULT_DATA_SLOT = "test202410json"
#const DEFAULT_DATA_SLOT = "test202410"

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
func save_data(data, data_slot: String = DEFAULT_DATA_SLOT) -> bool:
	var isString = type_string(typeof(data)) == "String"
	var json_string
	if isString:
		json_string = JSON.parse_string(data)
	else:
		json_string = JSON.stringify(data, "\t")

	if json_string == null:
		print("This data can't be parsed to json. save_data() has rejected new saved data to prevent corruption.")
		return false
	
	var file = get_file(SAVE_DIR + data_slot, FileAccess.WRITE)
	if file == null:
		print(FileAccess.get_open_error())
		return false
	
	if isString:
		file.store_string(data)
	else:
		file.store_string(json_string)
	#
	file.close()
	# print("Saved: " + SAVE_DIR + data_slot)
	return true


func _get_init_data():
	# This changes the default data.
	return {
		"data_ver":-99, # If data is incompatible with pervious data, might want to increment this number
		#"hp": 100,
		"pos":{
			"x": -1,
			"y": -1
		},
		#"item_pos":{
			###cleaneroption
			#{
				#"name": "coal",
				#"x": -1,
				#"y": -1
			#},
			###spaceefficientoption
			#"coal":{
				#[0]:{
					#"x": -1,
					#"y": -1
				#},
				#[1]:{
					#"x"
				#}
			#}
		#},
		"inventory":{
			"coal": 5,
			"coins": 0
		},
		#"terrain":2323 #seed??
	}
	

# assume an error if it's a string since it shouldn't be a string in other cases
func load_data(data_slot: String = DEFAULT_DATA_SLOT) -> Variant:
	var path = SAVE_DIR + data_slot
	# print(path)
	
	if FileAccess.file_exists(path):
		var file = get_file(path)
		if file == null:
			print("Could not load data from " + str(path) + ". Possible error message below:")
			print(FileAccess.get_open_error())
			return "Error: CannotOpenDataFile"

		var data = file.get_as_text()
		# This code assume that data is not corrupted btw
			
		# print(str(data) + " is real and won't hurt u")
		file.close()

		var json_data = JSON.parse_string(data)
		
		if json_data == null:
			printerr("Cannot load data from json. Data slot %s: (%s)" % [data_slot, data])
			return "Error: DataFileNotJson"
		else:
			print("Loaded: " + str(data))
			return json_data
	else:
		return _get_init_data()

		# init data + defaults

func del_data(data_slot): # Dangerous! No DEFAULT ID for safe measures ... can be changed later if desired.
	DirAccess.remove_absolute(SAVE_DIR + data_slot)
	print("Data from data slot " + data_slot + " has been cleared.")

# example functions

func _on_text_changed() -> void: # save data
	print("\nsaving text:")
	var txt = $".".text
	print(txt)
	if DataStore.save_data(txt):
		print("saved data!")
	else:
		print("failed to save data!")
	#save_data(txt, "test202410json")

func _on_button_pressed() -> void:
	DataStore.del_data(DEFAULT_DATA_SLOT)
	$".".text = str(load_data())

func _ready(): # load data
	verify_save_folder(SAVE_DIR)
	var data = DataStore.load_data()
	$".".text = str(data) + $".".text
	
	print("Your inventory: " + str(data["inventory"]))
	
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.start()
	await timer.timeout
	print("2 seconds have passed!")


	data["data_ver"] = 100000023
	DataStore.save_data(data)
	
	#print(type_string(typeof(data)))
