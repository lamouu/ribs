extends VBoxContainer

@export var item_scene = preload("res://scenes/ui/individual_item.tscn")
var player_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_node = get_node("/root/Node/Main/Player")
	player_node.inventory_updated.connect(_update_item_ui)

func _update_item_ui():
	remove_current_items()
	add_inventory_items()

func add_inventory_items():
	for item in player_node.inventory.items:
		var ui_item = item_scene.instantiate()
		ui_item.get_node("Sprite2D").texture = item.texture
		ui_item.get_node("Label").text = str(player_node.inventory.items[item])
		add_child(ui_item)

func remove_current_items():
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()
		
func stack_items():
	pass
