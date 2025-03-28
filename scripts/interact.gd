extends Area3D

@onready var interact = $"../Interaction"

var entered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("interact"):
				get_tree().change_scene_to_file("res://scenes/gamepc.tscn")
				interact.hide()


func _on_body_entered(body) -> void:
	if body.is_in_group("Player"):
		entered = true
		interact.show()


func _on_body_exited(body) -> void:
	if body.is_in_group("Player"):
		entered = false
		interact.hide()
