extends TextEdit


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

# Called when the node enters the scene tree for the first time.
func _ready(): # load data
	print("INIT data")
	verify_save_directory(SAVE_DIR)
	#load_data("SAVE_DIR + SAVE_FILE_NAMErobux")
	load_data("test202410")
	$".".text = str(data) + $".".text
	

func _on_text_changed() -> void: # save data
	print("\nsaving text:")
	var txt = $".".text
	print(txt)
	save_data("test202410", txt)



const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
const SECURITY_KEY = "©89SADFH"

#var player_data = PlayerData.new()
var player_data = {}
var data # tmp?

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)


func save_data(path: String, new_data): # data = temporary variable probably
	print('EXPERIMENTAL feature. May break.')
	path = SAVE_DIR + path
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		print(FileAccess.get_open_error())
		return

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


func load_data(path: String): # return change later?
	print('EXPERIMENTAL feature. May break.')
	path = SAVE_DIR + path
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if file == null:
			print(FileAccess.get_open_error())
			return

		var content = file.get_as_text()
		file.close()

		#var data = JSON.parse_string(content)
		data = content
		
		if data == null:
			#printerr("Cannot parse %s as a json_string: (%s)" % [path, content])
			printerr("Cannot parse %s: (%s)" % [path, content])
			return "gameerror loading data"
		else:
			print("Loaded: " + str(data))
			return data

		# init data + defaults

func del_data(path): # dangerous!
	#$".".clear() # this will fire .changed() so note two file writes may occur
	print("Deleting! (may have delay)\n")
	DirAccess.remove_absolute(SAVE_DIR + path)

	print("Reloading (after 1 second delay)")
	data = load_data("test202410")
	$".".text = str(data)

#save_data(SAVE_DIR + SAVE_FILE_NAME)
func _on_button_pressed() -> void:
	del_data("test202410")
	print("no wayy")
