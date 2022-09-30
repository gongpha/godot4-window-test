extends Sprite2D

@export var normal : Texture # reused cat texture (atlas)

var win : Window
var ground : float
var hit_ground : bool = false
const TASKBAR_HEIGHT := 48 # i cant communicate with DWM (on windows). sad

func _ready() :
	win = $"../../" # link to Outside Window
	set_process(false)
	
# start animating when jumeped
func animate() :
	win.visible = true
	win.transparent = true # idk why needed to set it twice
	ground = (win.size.y - texture.get_height() - (TASKBAR_HEIGHT * (win.content_scale_factor / 2.0))) / (win.content_scale_factor)
	set_process(true)
	
func _process(delta : float) :
	# Checking is touched a taskbar area (the height is 48px in win11)
	if position.y >= ground :
		if !hit_ground :
			texture = normal
			hframes = 2
			frame = 0
			hit_ground = true
		position.x += 32.0 * delta
		frame = min(int(wrap(0, 16, position.x)) / 16 % 2, 1) # swap 0, 1
		
		# Walks until off-screen then quit
		if position.x * win.content_scale_factor > win.size.x :
			get_tree().quit()
			return
	else :
		# gravity
		position.y += 80.0 * delta
		position.x += 4.0 * delta
