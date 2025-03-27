extends Node2D

var simultaneous_scene = "res://scenes/mainscene.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(simultaneous_scene)



func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
	

func _on_button_3_pressed() -> void:
	get_tree().quit()
