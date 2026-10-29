extends RefCounted
class_name SelectionItem

var id: Variant              # e.g., ResourceType.FOOD, "spearman", "barracks"
var title: String            # e.g., "Food", "Spearman", "Barracks"
var icon: Texture2D          # Optional display icon
var subtitle: String = ""    # Optional secondary text (e.g. "Cost: 5 Wood", "HP: 100")
var min_amount: int = 0
var max_amount: int = 99
var initial_amount: int = 0

func _init(
	p_id: Variant, 
	p_title: String, 
	p_icon: Texture2D = null, 
	p_max: int = 99, 
	p_subtitle: String = ""
) -> void:
	id = p_id
	title = p_title
	icon = p_icon
	max_amount = p_max
	subtitle = p_subtitle
