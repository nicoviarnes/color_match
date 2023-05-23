extends GridContainer

@export var grid_object : PackedScene
@export var grid_size : int
@export var match_sound : AudioStreamWAV
@export var error_sound : AudioStreamWAV
@export var gameover_sound : AudioStreamWAV

@onready var flip_timer = $FlipTimer
@onready var match_timer = $MatchTimer
@onready var end_timer = $EndTimer

signal update_score(score, maxScore)
signal shake_screen(intensity)
signal gameover

var possible_textures: Array = [
	"solid_blue_dollop",
	"solid_green_dollop",
	"solid_pink_dollop"
]
var base_grid_item_size = Vector2(448, 534)
var grid_item_size = Vector2(448, 534)
var sprite_offset = grid_item_size / 2

var grid_textures : Array = []
var grid_size_half

var choice_one = null
var choice_two = null

var flipping : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	make_grid()

func make_grid():
	set_columns(grid_size)
	
	grid_item_size = base_grid_item_size / grid_size
	sprite_offset = grid_item_size / 2
	
	var grid_size_square = grid_size * grid_size
	grid_size_half = grid_size_square / 2
	
	grid_textures.resize(grid_size_square)
	
	for i in range(grid_size_half):
		var tex = possible_textures.pick_random()
		grid_textures[i] = tex
		grid_textures[i + grid_size_half] = tex
	
	grid_textures.shuffle()

	emit_signal("update_score", 0, grid_size_half)
	render_board()

func render_board():
	for child in get_children():
		if child.is_in_group("grid_item"):
			child.queue_free()
	for tex in grid_textures:
		var new_grid_object = grid_object.instantiate()
		new_grid_object.custom_minimum_size = grid_item_size
		new_grid_object.cupcake_type = tex
	
		new_grid_object.selected.connect(select_tile)
		
		add_child(new_grid_object)

func check_for_match():
	if choice_one.cupcake_type != choice_two.cupcake_type:
		AudioManager.play(error_sound, -10.0)
		emit_signal("shake_screen", 20)
		choice_one.get_node("SmileTimer").stop()
		choice_one.get_node("BlinkTimer").stop()
		choice_two.get_node("SmileTimer").stop()
		choice_two.get_node("BlinkTimer").stop()
		choice_one.texture.current_frame = 6
		choice_two.texture.current_frame = 6
		choice_one.set_mouse_input(false)
		choice_two.set_mouse_input(false)
		flip_timer.start()
		return
		
	match_timer.start()

func select_tile(tile):
	if flipping:
		return

	if choice_one == null:
		choice_one = tile
		choice_one.flip_card(false)
		return

	if choice_two == null and tile != choice_one:
		choice_two = tile
		choice_two.flip_card(false)
		flipping = true
		check_for_match()

func settle_flip():
	reset_choices()

func match_found():
	AudioManager.play(match_sound, 0.0)
	choice_one.resolve_match()
	choice_two.resolve_match()
	reset_choices()
	emit_signal("update_score", 1, grid_size_half)

func reset_choices():
	if choice_one:
		choice_one.flip_card(false)
		choice_one.set_mouse_input(true)
	if choice_two:
		choice_two.flip_card(false)
		choice_two.set_mouse_input(true)
	choice_one = null
	choice_two = null
	flipping = false


func _on_level_timer_out_of_time():
	emit_signal("shake_screen", 200)
	for child in get_children():
		if child.is_in_group("grid_item"):
			child.get_node("SmileTimer").stop()
			child.get_node("BlinkTimer").stop()
			child.texture.current_frame = 4
			child.flip_card(true)
	end_timer.start()
	AudioManager.play(gameover_sound, 1.0)


func _on_end_timer_timeout():
	emit_signal("gameover")
