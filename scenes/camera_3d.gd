extends Camera3D

@export var move_speed: float = 5.0

func _process(delta):
	# Пример: движение камеры
	if Input.is_action_pressed("ui_right"):
		global_transform.origin += Vector3.RIGHT * move_speed * delta
