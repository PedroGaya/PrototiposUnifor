extends Timer

class_name SpawnTimer

@export var min_timer: float = 5
@export var max_timer: float = 20

func _ready():
	setup_timer()

func setup_timer():
	var random_timer = randf_range(min_timer, max_timer)
	self.wait_time = random_timer
	self.stop()
	self.start()
