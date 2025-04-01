extends Control

@onready var player = $"../CharacterBody3D"
@onready var inter = $"../Interaction"
@onready var gamepc = $"."
@onready var output = $GridContainer/Panel3/Output
@onready var code = $GridContainer/Panel/TextEdit
@onready var currdirlabel = $GridContainer/Panel5/cur_folder

var home_folders = ["downloads", "documents", "photos", "programming"]
var files = {"downloads": [], "documents": [], "photos": [], "programming": ["./script.sh"], "~": home_folders}
var commands = {"ls": "returns all files in a directory", "pwd": "returns current directory",\
 "cd": "change directory", "mkdir": "make directory", "rmdir": "remove directory", "help": "help",\
 "nmap": "scans ports", "ssh": "connecting"}
var cur_dir = '~'
var open_port = 443

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	code.add_theme_font_size_override("font_size", 30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("leaveterminal"):
		gamepc.hide()
		inter.show()
		player.set_meta("ingame", false)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_complete_pressed() -> void:
	var cur_command: String = ""
	cur_command = code.text
	if cur_command == "ls":
		if cur_dir == '~':
			output.text = ""
			for i in home_folders:
				output.text = output.text + i + "\n"
		else:
			output.text = ""
			for i in files[cur_dir]:
				output.text = output.text + i + "\n"
	elif "cd " in cur_command:
		var fold = cur_command.substr(3, cur_command.length())
		if " " in fold:
			output.text = "Not a folder!"
		elif fold not in files[cur_dir]:
			output.text = "This folder doesn't exist!"
		else:
			output.text = "Directory changed successfully!"
			cur_dir = fold
			currdirlabel.text = cur_dir
	elif cur_command == "help":
		output.text = ""
		for i in commands:
			output.text = output.text + i + " - " + commands[i] + "\n"
	elif "mkdir " in cur_command:
		output.text = "Directory created!"
		if cur_dir == "~":
			home_folders.append(cur_command.substr(6, cur_command.length()))
		else:
			output.text = "You can create folders only in home directory(~)"
	elif "rmdir " in cur_command:
		if cur_command.substr(6, cur_command.length()) in home_folders:
			output.text = "Directory deleted!"
			if cur_dir == "~":
				home_folders.erase(cur_command.substr(6, cur_command.length()))
			else:
				output.text = "You can remove folders only in home directory(~)"
		else:
			output.text = "No such directory!"
	elif cur_command == "pwd":
		output.text = cur_dir
	elif "nmap " in cur_command:
		var regex = RegEx.new()
		var _ip = regex.compile("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
		if regex.search(cur_command.substr(5, cur_command.length())):
			output.text = "Scanning " + cur_command.substr(5, cur_command.length()) + "..." + "\n"
			await get_tree().create_timer(2.0).timeout
			if cur_command.substr(5, cur_command.length()) == "192.168.1.2":
				output.text += "PORT" + "      " + "STATE" + "      " + "SERVICE"\
				 + "\n" + "443/tcp" + "      " + "open" + "      " + "ssl/http"
			else:
				output.text = "Scanning " + cur_command.substr(5, cur_command.length()) + "..." + "\n"
				await get_tree().create_timer(2.0).timeout
				output.text += "No ip in LAN!"
		else:
			output.text += "ip is not correct!"
	elif "ssh " in cur_command:
		if cur_dir == "programming":
			if cur_command.substr(4, cur_command.length()) == "192.168.1.2:443":
				output.text = "Connection complete!" + "\n" + "Loading script..."
				await get_tree().create_timer(2.0).timeout
				output.text = "Script loaded successfully!" + "\n" + "Minigame completed"
			else:
				output.text = "Connection lost..."
		else:
			output.text = "No script to load"
