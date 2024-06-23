extends DirectionalLight3D

var dummy = 0.00001

var time_start = 0
var time_now = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	
	$".".rotate_x(dummy)
	if dummy <= 0:
		dummy = 360
	elif dummy >= 360:
		dummy = 0
	pass
