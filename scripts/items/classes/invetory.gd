class_name Inventory

var items := {}

func add_item(new_item: Item):
	if new_item not in items:
		items[new_item] = 1
	else:
		items[new_item] += 1

func print_all():
	var s = ""
	
	for item in items:
		s += str(item.item_name) + "\n"
	
	print(s)
