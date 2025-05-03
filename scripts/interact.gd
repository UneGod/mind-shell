extends Area3D

@onready var interact = $"../Interaction/gamepcinter"
@onready var player = $"../CharacterBody3D"
@onready var gamepc = $"../Gamepc"
@onready var task = $"../task"

var entered = false

func _process(_delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("interact"):
			if task.get_meta("tasknumb") == 1:
				task.set_meta("tasknumb", 2)
			if task.get_meta("tasknumb") == 7:
				$"../task".set_meta("tasknumb", 8)
			gamepc.show()
			player.set_meta("ingame", true)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			interact.hide()


func _on_body_entered(body) -> void:
	if body.is_in_group("Player"):
		entered = true
		interact.show()

func _on_body_exited(body) -> void:
	if body.is_in_group("Player"):
		entered = false
		interact.hide()
