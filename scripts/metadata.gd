extends Control

@onready var player = $"../CharacterBody3D"
@onready var inter = $"../Interaction/gamepcinter3"
@onready var gamepc = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var meta_text = "Метаданные:\n"
	meta_text += "Camera: Jsdg936t8bk3 2589g \n"
	meta_text += "GPS: 48.5859195 N 96.6848158 W\n"
	meta_text += "Date: 19.07.2030 \n"
	meta_text += "Author: Nameless \n"
	meta_text += "Date: 19.07.1996 \n"
	meta_text += "mshellctf{m3tadata_fl4g0_o}"
	
	$HBoxContainer/VBoxContainer2/Label.text = meta_text


func _on_picyatdva_pressed() -> void:
	gamepc.hide()
	inter.show()
	player.set_meta("ingame", false)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
