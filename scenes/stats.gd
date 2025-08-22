extends Label

var player_node
var attack_cooldown_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_cooldown_node = get_node("/root/Node/Main/Player/AttackCooldown")
	player_node = get_node("/root/Node/Main/Player")
	player_node.inventory_updated.connect(update_stats)
	
	update_stats()

func update_stats():
	text = "speed: " + str(player_node.base_stats.speed) + "\ndamage: " + str(player_node.base_stats.attack_damage) + "\nattack speed: " + str(player_node.base_stats.attack_speed)
