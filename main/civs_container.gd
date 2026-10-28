extends VBoxContainer
class_name CivsContainer

const CIV_BOARD_SCENE = preload("res://civilizations/CivBoard.tscn")

@onready var civ_boards: GridContainer = $CivBoards

func _ready() -> void:
	populate_civ_boards()

func populate_civ_boards() -> void:
	for child in civ_boards.get_children():
		child.queue_free()

	for civ_key: String in CivData.CIV_DATA:
		var board: CivBoard = CIV_BOARD_SCENE.instantiate()
		civ_boards.add_child(board)
		board.civ_name = civ_key
		
		board.civ_inspected.connect(owner.open_inspect_modal)
