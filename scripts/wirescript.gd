extends Control

@onready var packet_list = $VBoxContainer/HSplitContainer/Packets
@onready var packet_details = $VBoxContainer/HSplitContainer/Tree2
@onready var player = $"../CharacterBody3D"
@onready var game = $"."
@onready var inter = $"../Interaction/gamepcinter2"

var started = false
var clickedbefore = false
var k = -1

func _ready():
	
	# Задаём названия колонок
	packet_list.set_column_title(0, "№")
	packet_list.set_column_title(1, "Time")
	packet_list.set_column_title(2, "Source")
	packet_list.set_column_title(3, "Destination")
	packet_list.set_column_title(4, "Protocol")
	packet_list.set_column_title(5, "Size")

func generate_random_string(length: int) -> String:
	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var random = RandomNumberGenerator.new()
	random.randomize()  # Важно: инициализация генератора
	var result = ""
	for i in range(length):
		result += chars[random.randi() % chars.length()]
	return result

func _on_button_pressed() -> void:
	started = true
	while true:
		if started:
			if k != 8:
				k += 1
				await get_tree().create_timer(2.0).timeout
				var packet = generate_random_string(16)
				var root = packet_list.create_item()
				var time = Time.get_time_string_from_system()
				var sourceip = generate_random_ip()
				var pr = get_random_protocol()
				root.set_text(0, str(k))
				root.set_text(1, time)
				root.set_text(2, sourceip)  # Заглушка (реальный IP из парсинга)
				root.set_text(3, generate_random_ip())      # Заглушка
				root.set_text(4, pr)           # Определяем по данным пакета
				root.set_text(5, "16")
				
				var root1 = packet_details.create_item()
				
				# Ethernet заголовок (пример)
				var eth = packet_details.create_item(root1)
				eth.set_text(0, "Ethernet")
				eth.set_text(1, "Src MAC: " + generate_random_mac())
				var ip = packet_details.create_item(root1)
				ip.set_text(0, "IPv4")
				ip.set_text(1, "Source: " + sourceip)
				var messag = packet_details.create_item(root1)
				messag.set_text(0, "Protocol: " + pr)
				messag.set_text(1, "Message: " + packet + "==")
			else:
				k += 1
				await get_tree().create_timer(2.0).timeout
				var packet = generate_random_string(16)
				var root = packet_list.create_item()
				var time = Time.get_time_string_from_system()
				var pr = get_random_protocol()
				root.set_text(0, str(k))
				root.set_text(1, time)
				root.set_text(2, "192.168.1.2")  # Заглушка (реальный IP из парсинга)
				root.set_text(3, generate_random_ip())      # Заглушка
				root.set_text(4, pr)           # Определяем по данным пакета
				root.set_text(5, "16")
				
				var root1 = packet_details.create_item()
				
				# Ethernet заголовок (пример)
				var eth = packet_details.create_item(root1)
				eth.set_text(0, "Ethernet")
				eth.set_text(1, "Src MAC: " + generate_random_mac())
				var ip = packet_details.create_item(root1)
				ip.set_text(0, "IPv4")
				ip.set_text(1, "Source: " + "192.168.1.2")
				var messag = packet_details.create_item(root1)
				messag.set_text(0, "Protocol: " + pr)
				messag.set_text(1, "Message: " + "cGFzc3toZWxsbzEwfQ==")
		else:
			break
		

func _on_button_2_pressed() -> void:
	started = false
	
func generate_random_ip() -> String:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return "%d.%d.%d.%d" % [
		rng.randi_range(0, 255),
		rng.randi_range(0, 255),
		rng.randi_range(0, 255),
		rng.randi_range(0, 255)
	]

func get_random_protocol() -> String:
	var protocols = ["TCP", "ARP", "HTTP", "FTP", "TELNET"]
	return protocols[randi() % protocols.size()]
	
func generate_random_mac() -> String:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var mac_parts = []
	for i in 6:
		mac_parts.append("%02X" % rng.randi_range(0, 255))
	return ":".join(mac_parts)


func _on_button_3_pressed() -> void:
	game.hide()
	inter.show()
	player.set_meta("ingame", false)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
