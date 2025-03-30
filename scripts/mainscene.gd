extends Node3D

# Убедитесь, что камера и затемнитель правильно инициализированы
@onready var darkener = $Darkener
@onready var camera = $Camera3D

func _ready():
	# Настройка начальной позиции камеры (опционально)
	camera.global_transform.origin = Vector3(0, 2, 5)
	camera.look_at(Vector3.ZERO)
