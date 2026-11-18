extends Node2D

const creep_scene = preload("res://scenes/creep.tscn")
var health = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%HealthAmountLabel.text = str(health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var spawned_creep = creep_scene.instantiate()
	%Path2D.add_child(spawned_creep)
	spawned_creep.reached_end.connect(_on_creep_reached_end)
	
func _on_creep_reached_end():
	health -= 1
	%HealthAmountLabel.text = str(health)
	if health <= 0:
		
		get_tree().quit(0)
