extends Sprite2D

@export var normal : Texture

var win : Window
var ground : float
var hit_ground : bool = false
const TASKBAR_HEIGHT := 48

func _ready() :
	win = $"../../"
	set_process(false)
	
func animate() :
	win.visible = true
	win.transparent = true
	ground = (win.size.y - texture.get_height() - (TASKBAR_HEIGHT * (win.content_scale_factor / 2.0))) / (win.content_scale_factor)
	set_process(true)
	
func _process(delta : float) :
	
	if position.y >= ground :
		if !hit_ground :
			texture = normal
			hframes = 2
			frame = 0
			hit_ground = true
		position.x += 32.0 * delta
		frame = min(int(wrap(0, 16, position.x)) / 16 % 2, 1) # swap 0, 1
		
		if position.x * win.content_scale_factor > win.size.x :
			get_tree().quit()
			return
	else :
		#print(position.y, ground)
		position.y += 80.0 * delta
		position.x += 4.0 * delta
	
	


func _on_001_timeout():
	set_process(true)
