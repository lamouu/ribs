extends Control

signal inventory_updated

var player_node
var available_items = Items.available_items
var shop_items: Dictionary

func _ready() -> void:
	player_node = get_node("/root/Node/Main/Player")

func roll_items():
	available_items = Items.available_items.duplicate()
	shop_items = {}
	
	for item_button in [$Item1, $Item2, $Item3]:
		var rolled_item = available_items.keys().pick_random()
		
		shop_items[item_button] = available_items[rolled_item]
		item_button.texture_normal = shop_items[item_button].texture
		
		available_items.erase(rolled_item)


func _on_item_1_pressed() -> void:
	player_node.inventory.add_item(shop_items[$Item1])
	player_node.inventory_updated.emit()


func _on_item_2_pressed() -> void:
	player_node.inventory.add_item(shop_items[$Item2])
	player_node.inventory_updated.emit()


func _on_item_3_pressed() -> void:
	player_node.inventory.add_item(shop_items[$Item3])
	player_node.inventory_updated.emit()


func _on_refresh_pressed() -> void:
	roll_items()
