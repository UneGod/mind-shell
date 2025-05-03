extends Panel

var current_url = "https://google.com"
var history = []
var history_index = -1

@onready var address_bar = $AddressBar
@onready var web_display = $WebDisplay

func _ready():
	load_page(current_url)

func load_page(url):
	if url.begins_with("http://") or url.begins_with("https://"):
		current_url = url
	else:
		current_url = "https://" + url
	
	address_bar.text = current_url

	web_display.text = "Загружено: " + current_url

	if history.is_empty() or history[-1] != current_url:
		history.append(current_url)
		history_index = history.size() - 1
