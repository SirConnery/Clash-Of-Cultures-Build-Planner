extends Node
class_name CivData

static func get_all_civ_tech_boards() -> Array[Texture2D]:
	var boards: Array[Texture2D] = []
	for civ_key: String in CIV_DATA:
		boards.append(CIV_DATA[civ_key]["tech_board"])
	return boards

## Returns a Dictionary with the "tech_board" (Texture2D) and "leaders" (Array[Texture2D]) for the given civ_key.
## Returns an empty dictionary if the civ_key is invalid.
static func get_civ_tech_board_and_leaders(civ_key: String) -> Dictionary:
	civ_key = civ_key.to_lower()
	if not CIV_DATA.has(civ_key):
		push_error("CivDatabase: Civilization '%s' not found." % civ_key)
		return {}
	
	var data: Dictionary = CIV_DATA[civ_key]
	return {
		"tech_board": data["tech_board"],
		"leaders": data["leaders"]
	}

const CIV_DATA: Dictionary = {
	"aztecs": {
		"civ_name": "Aztecs",
		"tech_board": preload("res://assets/img/civilizations/aztecs.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/aztecs/acamapichtli.jpg"),
			preload("res://assets/img/cards/leaders/aztecs/ahuitzotl.jpg"),
			preload("res://assets/img/cards/leaders/aztecs/marqzen.jpg"),
		]
	},
	"babylonia": {
		"civ_name": "Babylonia",
		"tech_board": preload("res://assets/img/civilizations/babylonia.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/babylonia/hammurabi.jpg"),
			preload("res://assets/img/cards/leaders/babylonia/nabopolassar.jpg"),
			preload("res://assets/img/cards/leaders/babylonia/nebuchadnezzar_ii.jpg")
		]
	},
	"carthage": {
		"civ_name": "Carthage",
		"tech_board": preload("res://assets/img/civilizations/carthage.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/carthage/hannibal.jpg"),
			preload("res://assets/img/cards/leaders/carthage/hanno.jpg"),
			preload("res://assets/img/cards/leaders/carthage/queen_dido.jpg")
		]
	},
	"celts": {
		"civ_name": "Celts",
		"tech_board": preload("res://assets/img/civilizations/celts.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/celts/queen_boudica.jpg"),
			preload("res://assets/img/cards/leaders/celts/vercingetorix.jpg"),
			preload("res://assets/img/cards/leaders/celts/viriatus.jpg")
		]
	},
	"china": {
		"civ_name": "China",
		"tech_board": preload("res://assets/img/civilizations/china.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/china/empress_wu_zetian.jpg"),
			preload("res://assets/img/cards/leaders/china/qin_shi_huang.jpg"),
			preload("res://assets/img/cards/leaders/china/sun_tzu.jpg")
		]
	},
	"egypt": {
		"civ_name": "Egypt",
		"tech_board": preload("res://assets/img/civilizations/egypt.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/egypt/cleopatra.jpg"),
			preload("res://assets/img/cards/leaders/egypt/imhotep.jpg"),
			preload("res://assets/img/cards/leaders/egypt/ramses_ii.jpg")
		]
	},
	"greece": {
		"civ_name": "Greece",
		"tech_board": preload("res://assets/img/civilizations/greece.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/greece/alexander_the_great.jpg"),
			preload("res://assets/img/cards/leaders/greece/leonidas.jpg"),
			preload("res://assets/img/cards/leaders/greece/pericles.jpg")
		]
	},
	"huns": {
		"civ_name": "Huns",
		"tech_board": preload("res://assets/img/civilizations/huns.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/huns/attila.jpg"),
			preload("res://assets/img/cards/leaders/huns/bleda.jpg"),
			preload("res://assets/img/cards/leaders/huns/rugila.jpg")
		]
	},
	"india": {
		"civ_name": "India",
		"tech_board": preload("res://assets/img/civilizations/india.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/india/ahoka_the_great.jpg"),
			preload("res://assets/img/cards/leaders/india/akbar_the_great.jpg"),
			preload("res://assets/img/cards/leaders/india/maharaja_sri_gupta.jpg")
		]
	},
	"japan": {
		"civ_name": "Japan",
		"tech_board": preload("res://assets/img/civilizations/japan.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/japan/emperor_go_toba.jpg"),
			preload("res://assets/img/cards/leaders/japan/emperor_jimmu.jpg"),
			preload("res://assets/img/cards/leaders/japan/empress_suiko.jpg")
		]
	},
	"maya": {
		"civ_name": "Maya",
		"tech_board": preload("res://assets/img/civilizations/maya.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/maya/kinich_janaab_pakal.jpg"),
			preload("res://assets/img/cards/leaders/maya/siyaj_kak.jpg"),
			preload("res://assets/img/cards/leaders/maya/wak_chanil_ajaw.jpg")
		]
	},
	"persia": {
		"civ_name": "Persia",
		"tech_board": preload("res://assets/img/civilizations/persia.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/persia/cyrus_the_great.jpg"),
			preload("res://assets/img/cards/leaders/persia/darius.jpg"),
			preload("res://assets/img/cards/leaders/persia/xerxes.jpg")
		]
	},
	"phoenicia": {
		"civ_name": "Phoenicia",
		"tech_board": preload("res://assets/img/civilizations/phoenicia.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/phoenicia/ithobaal.jpg"),
			preload("res://assets/img/cards/leaders/phoenicia/king_hiram.jpg"),
			preload("res://assets/img/cards/leaders/phoenicia/pygmalium.jpg")
		]
	},
	"rome": {
		"civ_name": "Rome",
		"tech_board": preload("res://assets/img/civilizations/rome.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/rome/emperor_augustus.jpg"),
			preload("res://assets/img/cards/leaders/rome/gaius_julius_caesar.jpg"),
			preload("res://assets/img/cards/leaders/rome/sulla.jpg")
		]
	},
	"vikings": {
		"civ_name": "Vikings",
		"tech_board": preload("res://assets/img/civilizations/vikings.jpg"),
		"leaders": [
			preload("res://assets/img/cards/leaders/vikings/cnut_the_great.jpg"),
			preload("res://assets/img/cards/leaders/vikings/eric_the_red.jpg"),
			preload("res://assets/img/cards/leaders/vikings/ragnard_lodbrok.jpg")
		]
	}
}
