extends PathFollow2D

@export var speed := 30.0 # px per second
var health := 6
signal reached_end
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio >= 1.0:
		reached_end.emit()
		queue_free()
	

func hurt(amount: int):
	assert(amount >= 0)
	health -= amount
	if health <= 0:
		print('death')
		queue_free()
