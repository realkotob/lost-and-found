tool
extends "base_parameter.gd"


var _is_int := false
var _is_enum := false

onready var _label: Label = $Label
onready var _spinbox: SpinBox = $MarginContainer/MarginContainer/SpinBox
onready var _option: OptionButton = $MarginContainer/MarginContainer/OptionButton


func _ready() -> void:
	_spinbox.connect("value_changed", self, "_on_value_changed")
	_option.connect("item_selected", self, "_on_value_changed")
	mark_as_int(_is_int)


func mark_as_int(val: bool) -> void:
	_is_int = val
	if _is_int and _spinbox:
		_spinbox.step = 1


func set_parameter_name(text: String) -> void:
	_label.text = text


func set_hint_string(hint: String) -> void:
	# No hint provided, ignore.
	if hint.empty():
		return

	# One integer provided
	if hint.is_valid_integer():
		_set_range(0, int(hint))
		return

	# Multiple items provided, check their types
	var tokens = hint.split(",")
	var all_int = true
	var all_float = true

	for t in tokens:
		if not t.is_valid_integer():
			all_int = false
		if not t.is_valid_float():
			all_float = false

	# All items are integer
	if all_int and tokens.size() >= 2:
		_set_range(int(tokens[0]), int(tokens[1]))
		return

	# All items are float
	if all_float:
		if tokens.size() >= 2:
			_set_range(float(tokens[0]), float(tokens[1]))
		if tokens.size() >= 3:
			_spinbox.step = float(tokens[2])
		return

	# All items are strings, make it a dropdown
	_spinbox.visible = false
	_option.visible = true
	_is_enum = true
	_is_int = true

	for i in tokens.size():
		_option.add_item(tokens[i], i)
	set_value(int(_spinbox.get_value()))


func get_value():
	if _is_enum:
		return _option.get_selected_id()
	if _is_int:
		return int(_spinbox.get_value())
	return _spinbox.get_value()


func _set_value(val) -> void:
	if _is_int:
		val = int(val)
	if _is_enum:
		_option.select(val)
	else:
		_spinbox.set_value(val)


func _set_range(start, end) -> void:
	if start < end:
		_spinbox.min_value = start
		_spinbox.max_value = end
		_spinbox.allow_greater = false
		_spinbox.allow_lesser = false
