extends TextureRect
class_name InspectorCard

@onready var highlight: CardHighlightComponent = $CardHighlightComponent

#region Highlight component

func _has_point(point: Vector2) -> bool:
	if highlight:
		return highlight.get_display_rect().has_point(point)
	return Rect2(Vector2.ZERO, size).has_point(point)
