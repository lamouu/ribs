extends CanvasLayer
var time_node
var player_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_node = get_node("../../GameTime")
	player_node = get_node("../../Player")
	
	$Time.show()
	$Score.show()
	$Health.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_time()
	update_score()
	update_health()

func update_time():
	$Time.text = "time: " + str(int(1000000000 - time_node.time_left)) + "s"

func update_score():
	$Score.text = "score placeholder"

func update_health():
	$Health.text = "health: " + str(player_node.health)
