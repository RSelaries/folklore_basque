extends Node


func rgb_to_hsv(color: Color) -> Vector3:
	var r = color.r
	var g = color.g
	var b = color.b

	var max_c = max(r, g, b)
	var min_c = min(r, g, b)
	var delta = max_c - min_c

	var h = 0.0
	if delta > 0.0:
		if max_c == r:
			h = fmod((g - b) / delta, 6.0)
		elif max_c == g:
			h = ((b - r) / delta) + 2.0
		else:  # max_c == b
			h = ((r - g) / delta) + 4.0
		h /= 6.0
		if h < 0.0:
			h += 1.0

	var s = 0.0 if max_c == 0.0 else delta / max_c
	var v = max_c

	return Vector3(h, s, v)


func hsv_to_rgb(hsv: Vector3) -> Color:
	var h = hsv.x * 6.0
	var s = hsv.y
	var v = hsv.z

	var c = v * s
	var x = c * (1.0 - abs(fmod(h, 2.0) - 1.0))
	var m = v - c

	var r = 0.0
	var g = 0.0
	var b = 0.0

	match int(h):
		0:
			r = c; g = x; b = 0
		1:
			r = x; g = c; b = 0
		2:
			r = 0; g = c; b = x
		3:
			r = 0; g = x; b = c
		4:
			r = x; g = 0; b = c
		5:
			r = c; g = 0; b = x
		_:
			r = 0; g = 0; b = 0

	return Color(r + m, g + m, b + m)


func get_all_children(in_node: Node, arr: Array[Node] = []):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr
