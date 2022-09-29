extends Node2D

const WINDOW := preload("res://sub/000/001.tscn")

var mainwin : Window
var window : Window

func _ready() :
	mainwin = get_viewport()
	mainwin.transparent = true
	mainwin.transparent_bg = true
	
const SAFE_RECT := Vector2i(300, 80)

func spawn_window() :
	window = WINDOW.instantiate()
	add_child(window, true)
	
	

func window_animate() :
	var res := DisplayServer.screen_get_size()
	window.position = (mainwin.position + mainwin.size) - SAFE_RECT
	window.size = res - window.position
	window.get_node("000/000").animate()
	mainwin.grab_focus()
