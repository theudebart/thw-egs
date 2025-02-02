THREE = require "THREE"
{ Helpers } = require "../Helpers"

class Betonplatte extends THREE.Geometry

	_Betonplatte: (length, width, height, x, y , h) ->
		new THREE.BoxGeometry(length, height, width)

	constructor: (length, width, height, x, y, h) ->
		super()

		@merge @_Betonplatte(10 * length, 10 * width, 10 * height)

		@applyMatrix4 Helpers.matrix(10*x, 10*h, 10*y)

module.exports = Betonplatte
