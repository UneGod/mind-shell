extends Panel

var current_url = "https://google.com"  # Стартовая страница
var history = []  # История посещений
var history_index = -1  # Текущая позиция в истории

@onready var address_bar = $AddressBar  # LineEdit
@onready var web_display = $WebDisplay  # RichTextLabel (или нода для WebView)

func _ready():
	load_page(current_url)

# Загрузка страницы (упрощённая версия)
func load_page(url):
	if url.begins_with("http://") or url.begins_with("https://"):
		current_url = url
	else:
		current_url = "https://" + url
	
	address_bar.text = current_url
	
	# В реальном проекте здесь будет загрузка через HTTPRequest или WebView
	web_display.text = "Загружено: " + current_url
	
	# Добавляем в историю (если не дубликат)
	if history.is_empty() or history[-1] != current_url:
		history.append(current_url)
		history_index = history.size() - 1
