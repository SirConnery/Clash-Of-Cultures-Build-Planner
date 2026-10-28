extends Node
class_name CardHighlightComponent

## The target Control to highlight. If null, defaults to its parent node.
@export var target_control: Control = null

@export_group("Hover & Animation")
@export var hover_scale: Vector2 = Vector2(1.08, 1.08)
@export var tween_duration: float = 0.15
@export var elevated_z_index: int = 10

@export_group("Border Styling")
@export var border_color: Color = Color(1.0, 0.84, 0.15) # Gold
@export var shadow_color: Color = Color(0.0, 0.0, 0.0, 0.7)
@export var border_width: float = 4.0
@export var enable_shadow: bool = true

## Also allows permanent selection highlighting (e.g. active tech board)
@export var is_selected: bool = false:
	set(value):
		is_selected = value
		_update_state()

var is_hovered: bool = false
var _target: Control = null
var _tween: Tween = null
var _base_z_index: int = 0

func _ready() -> void:
	_target = target_control if target_control != null else get_parent() as Control
	if not _target:
		push_error("CardHighlightComponent: Target control not found!")
		return

	_base_z_index = _target.z_index
	_target.mouse_filter = Control.MOUSE_FILTER_STOP

	# Hook lifecycle events
	_target.resized.connect(_update_pivot)
	_target.mouse_entered.connect(_on_mouse_entered)
	_target.mouse_exited.connect(_on_mouse_exited)
	_target.draw.connect(_on_target_draw)

	_update_pivot()

func _update_pivot() -> void:
	if _target:
		_target.pivot_offset = _target.size * 0.5

## Calculates visible texture area if target is a TextureRect with Keep Aspect Centered
func get_display_rect() -> Rect2:
	if not _target:
		return Rect2()

	if _target is TextureRect:
		var tex_rect := _target as TextureRect
		if tex_rect.texture:
			var tex_size: Vector2 = tex_rect.texture.get_size()
			if tex_size.x > 0.0 and tex_size.y > 0.0 and tex_rect.stretch_mode == TextureRect.STRETCH_KEEP_ASPECT_CENTERED:
				var scale_factor: float = minf(_target.size.x / tex_size.x, _target.size.y / tex_size.y)
				var display_size: Vector2 = tex_size * scale_factor
				var display_pos: Vector2 = (_target.size - display_size) * 0.5
				return Rect2(display_pos, display_size)

	return Rect2(Vector2.ZERO, _target.size)

func _on_target_draw() -> void:
	if not (is_hovered or is_selected):
		return

	var rect: Rect2 = get_display_rect()
	var half_stroke: float = border_width * 0.5
	var draw_area := Rect2(
		rect.position + Vector2(half_stroke, half_stroke),
		rect.size - Vector2(border_width, border_width)
	)

	if enable_shadow:
		_target.draw_rect(draw_area.grow(1.0), shadow_color, false, border_width + 1.0)
	_target.draw_rect(draw_area, border_color, false, border_width)

func _on_mouse_entered() -> void:
	is_hovered = true
	_update_state()

func _on_mouse_exited() -> void:
	is_hovered = false
	_update_state()

func _update_state() -> void:
	if not _target:
		return

	_update_pivot()
	_target.queue_redraw()

	var should_highlight: bool = is_hovered or is_selected

	if _tween and _tween.is_valid():
		_tween.kill()

	_tween = create_tween().set_parallel(true)

	if should_highlight:
		_target.z_index = elevated_z_index
		_tween.tween_property(_target, "scale", hover_scale, tween_duration)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_OUT)
	else:
		_tween.tween_property(_target, "scale", Vector2.ONE, tween_duration)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_OUT)
		_tween.chain().tween_callback(func() -> void:
			if not (is_hovered or is_selected):
				_target.z_index = _base_z_index
		)
