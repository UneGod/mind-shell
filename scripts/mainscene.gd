extends Node3D

@onready var menu = $Menu
@onready var pl = $CharacterBody3D
@onready var task = $task

func _ready() -> void:
	pass

func _process(_delta) -> void:
	if Input.is_action_just_pressed("leavegame"):
		get_tree().quit()
	if Input.is_action_just_pressed("menu"):
		if !pl.get_meta("ingame"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			menu.show()
	if Input.is_action_just_pressed("book"):
		if !$book.is_visible_in_tree():
			if !pl.get_meta("ingame"):
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				$book.show()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			$book.hide()
			$notes.hide()
			$flags.hide()
