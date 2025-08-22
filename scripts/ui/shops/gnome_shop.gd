extends Control

func roll_items():
	var available_items = Items.available_items.duplicate()
	var shop_items: Dictionary
	
	for item_button in [$Item1, $Item2, $Item3]:
		var rolled_item = available_items.keys().pick_random()
		
		item_button.texture_normal = available_items[rolled_item].texture
		
		available_items.erase(rolled_item)
