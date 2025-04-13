extends Panel

var current_tab = 0
var tabs = []  # Массив вкладок {url, title, history, history_index}
var history = []  # Общая история

@onready var tab_container = $TabContainer
@onready var address_bar = $NavigationBar/AddressBar
@onready var page_loader = $PageLoader
@onready var progress_bar = $ProgressBar

func _ready():
	add_new_tab("https://google.com")
	setup_buttons()

# Настройка кнопок
func setup_buttons():
	$NavigationBar/BackButton.pressed.connect(_on_back_button_pressed)
	$NavigationBar/ForwardButton.pressed.connect(_on_forward_button_pressed)
	$NavigationBar/RefreshButton.pressed.connect(_on_refresh_button_pressed)
	$NavigationBar/HomeButton.pressed.connect(_on_home_button_pressed)
	$TabBar/AddTabButton.pressed.connect(_on_add_tab_button_pressed)
	address_bar.text_submitted.connect(_on_address_bar_text_submitted)

# Добавление вкладки
func add_new_tab(url: String):
	var new_tab = {
		"url": url,
		"title": "Новая вкладка",
		"history": [url],
		"history_index": 0
	}
	tabs.append(new_tab)
	update_tabs_ui()
	load_page(url)

# Загрузка страницы
func load_page(url: String):
	if !url.begins_with("http"):
		url = "https://" + url
	
	progress_bar.visible = true
	tabs[current_tab]["url"] = url
	page_loader.request(url)

# Обновление UI вкладок
func update_tabs_ui():
	for i in range($TabBar.get_child_count() - 1):
		$TabBar.get_child(i).queue_free()
	
	for i in range(tabs.size()):
		var tab_button = Button.new()
		tab_button.text = tabs[i]["title"]
		tab_button.pressed.connect(_on_tab_selected.bind(i))
		$TabBar.add_child(tab_button)
	
	$TabBar.move_child($TabBar/AddTabButton, tabs.size())

# Обработка загрузки страницы
func _on_page_loader_request_completed(result, response_code, headers, body):
	progress_bar.visible = false
	if response_code == 200:
		var html = body.get_string_from_utf8()
		var simplified_text = strip_html_tags(html)
		tab_container.get_child(current_tab).text = simplified_text
	else:
		tab_container.get_child(current_tab).text = "Ошибка: " + str(response_code)

# Упрощённый парсер HTML
func strip_html_tags(html: String) -> String:
	var regex = RegEx.new()
	regex.compile("<[^>]+>")
	return regex.sub(html, "", true)

# --- КНОПКИ --- #
func _on_back_button_pressed():
	if tabs[current_tab]["history_index"] > 0:
		tabs[current_tab]["history_index"] -= 1
		load_page(tabs[current_tab]["history"][tabs[current_tab]["history_index"]])

func _on_forward_button_pressed():
	if tabs[current_tab]["history_index"] < tabs[current_tab]["history"].size() - 1:
		tabs[current_tab]["history_index"] += 1
		load_page(tabs[current_tab]["history"][tabs[current_tab]["history_index"]])

func _on_refresh_button_pressed():
	load_page(tabs[current_tab]["url"])

func _on_home_button_pressed():
	load_page("https://google.com")

func _on_add_tab_button_pressed():
	add_new_tab("https://google.com")

func _on_tab_selected(tab_index):
	current_tab = tab_index
	address_bar.text = tabs[tab_index]["url"]
	tab_container.current_tab = tab_index

func _on_address_bar_text_submitted(new_text):
	load_page(new_text)
