extends GridContainer

@export var grid_object : PackedScene
@export var grid_size : int

@onready var flip_timer = $FlipTimer
@onready var match_timer = $MatchTimer

signal update_score(score, maxScore)

var possible_textures: Array = [
	"solid_blue_dollop",
	"solid_green_dollop"
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
		print("No match")
		print(choice_one.cupcake_type,choice_two.cupcake_type)
		choice_one.set_mouse_input(false)
		choice_two.set_mouse_input(false)
		flip_timer.start()
		return
		
	print("matched")
	match_timer.start()

func select_tile(tile):
	if flipping:
		return

	if choice_one == null:
		choice_one = tile
		choice_one.flip_card()
		return

	if choice_two == null and tile != choice_one:
		choice_two = tile
		choice_two.flip_card()
		flipping = true
		check_for_match()

func settle_flip():
	reset_choices()

func match_found():
	choice_one.resolve_match()
	choice_two.resolve_match()
	reset_choices()
	emit_signal("update_score", 1, grid_size_half)

func reset_choices():
	if choice_one:
		choice_one.flip_card()
		choice_one.set_mouse_input(true)
	if choice_two:
		choice_two.flip_card()
		choice_two.set_mouse_input(true)
	choice_one = null
	choice_two = null
	flipping = false
