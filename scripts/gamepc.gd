extends Control

@onready var player = $"../CharacterBody3D"
@onready var inter = $"../Interaction"
@onready var gamepc = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("leaveterminal"):
		gamepc.hide()
		inter.show()
		player.set_meta("ingame", false)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
