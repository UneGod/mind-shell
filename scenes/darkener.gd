# darkener.gd
extends MeshInstance3D

@export var fade_speed: float = 2.0      # Скорость анимации
@export var max_alpha: float = 0.7       # Максимальная непрозрачность
@export var distance_to_camera: float = 3.0  # Дистанция до камеры

var target_alpha: float = 0.0
var material: StandardMaterial3D
@onready var camera: Camera3D = get_viewport().get_camera_3d()

func _ready():
	# Инициализация материала
	material = mesh.surface_get_material(0).duplicate()
	mesh.surface_set_material(0, material)
	update_position()

func _process(delta):
	# Плавное изменение прозрачности
	material.albedo_color.a = move_toward(
		material.albedo_color.a,
		target_alpha,
		fade_speed * delta
	)
	# Обновление позиции перед камерой
	update_position()

func _input(event: InputEvent):
	if event.is_action_pressed("toggle_darkness"):
		toggle_darkness()

func toggle_darkness():
	target_alpha = max_alpha if (target_alpha == 0.0) else 0.0

func update_position():
	if camera:
		global_transform.origin = camera.global_position + camera.global_transform.basis.z * distance_to_camera
		look_at(camera.global_position)
