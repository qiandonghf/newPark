var x = 50, y = 60
var xin = true, yin = true
var step = 1
var delay = 30
var obj = document.getElementById("img1")
function float() {
	var L = T = 0
	var R = document.documentElement.clientWidth - obj.offsetWidth
	var B = document.documentElement.clientHeight - obj.offsetHeight
	obj.style.left = x + document.documentElement.scrollLeft
	obj.style.top = y + document.documentElement.scrollTop
	x = x + step * (xin ? 1 : -1)
	if (x < L) {
		xin = true;
		x = L
	}
	if (x > R) {
		xin = false;
		x = R
	}
	y = y + step * (yin ? 1 : -1)
	if (y < T) {
		yin = true;
		y = T
	}
	if (y > B) {
		yin = false;
		y = B
	}
}
var itl = setInterval("float()", delay)
obj.onmouseover = function() {
	clearInterval(itl)
}
obj.onmouseout = function() {
	itl = setInterval("float()", delay)
}