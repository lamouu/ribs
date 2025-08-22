extends Node

# Item resource paths
const BURRITO: Item = preload("res://resources/items/burrito.tres")
const HAMMER: Item = preload("res://resources/items/hammer.tres")
const WHETSTONE: Item = preload("res://resources/items/whetstone.tres")

# Item list
var all_items = [
	BURRITO,
	HAMMER,
	WHETSTONE
]

var available_items := {}

func _ready() -> void:
	_register_items()

# will be used to remove unique items from the item pool
func _register_items() -> void:
	for item in all_items:
		available_items[item.item_name] = item
