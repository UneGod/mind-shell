extends Node3D

@onready var dark = $DirectionalLight3D
@onready var menu = $Menu
@onready var pl = $CharacterBody3D
@onready var task = $task

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta) -> void:
	if Input.is_action_just_pressed("darktheme"):
		dark.light_color = Color(0, 0, 0, 13)
	if Input.is_action_just_pressed("backdark"):
		dark.light_color = Color(1, 1, 1)
	if Input.is_action_just_pressed("leavegame"):
		get_tree().quit()
	if Input.is_action_just_pressed("menu"):
		if !pl.get_meta("ingame"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			menu.show()
