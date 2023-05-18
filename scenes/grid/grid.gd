extends GridContainer

@export var grid_object : PackedScene
@export var grid_size : int

@onready var flip_timer = $FlipTimer
@onready var match_timer = $MatchTimer

var possible_colors: Array = [
	Color.AQUA,
	Color.BLACK,
	Color.CYAN,
	Color.DARK_GREEN,
	Color.DEEP_PINK,
	Color.FIREBRICK,
	Color.IVORY,
	Color.LAWN_GREEN,
	Color.LIGHT_BLUE
]

var grid_colors : Array = []

var choice_one = null
var choice_two = null

var flipping : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	make_grid()

func make_grid():
	set_columns(grid_size)
	
	var grid_size_square = grid_size * grid_size
	var grid_size_half = grid_size_square / 2
	
	grid_colors.resize(grid_size_square)
	
	for i in range(grid_size_half):
		var color = possible_colors.pick_random()
		grid_colors[i] = color
		grid_colors[i + grid_size_half] = color
	
	grid_colors.shuffle()

	render_board()

func render_board():
	for color in grid_colors:
		var new_grid_object = grid_object.instantiate()
		new_grid_object.color = color
		new_grid_object.selected.connect(select_tile)
		add_child(new_grid_object)

func check_for_match():
	if choice_one.color != choice_two.color:
		print("No match")
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