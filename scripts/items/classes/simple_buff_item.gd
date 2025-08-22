class_name SimpleBuffItem extends Item

@export var speed_buff := 1.0
@export var attack_damage_buff := 1.0
@export var attack_speed_buff := 1.0

func apply_buff(stats):
	stats.speed *= speed_buff
	stats.attack_damage *= attack_damage_buff
	stats.attack_speed *= attack_speed_buff
	
	return stats
