extends Area3D

@onready var interact = $"../Interaction"
@onready var player = $"../CharacterBody3D"
@onready var gamepc = $"../Gamepc"

var entered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("interact"):
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
