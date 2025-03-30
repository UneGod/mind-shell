extends Button

@onready var darkener = $"../../Darkener"  # Путь от кнопки к Darkener

func _ready():
	connect("pressed", Callable(darkener, "toggle_darkness"))
