THREE = require "THREE"
{ Helpers } = require "../Helpers"

class Ankerstab extends THREE.Geometry

	_Ankerstab: (length) ->
		a = new THREE.Geometry
		a.merge Helpers.cylinder(15, 0, length)
		a.applyMatrix4 Helpers.matrix(0,0,0, 'Y', 1)
		a.applyMatrix4 Helpers.matrix(0,0,0, 'X', -1)
		a

	constructor: (length, x, y, h, special) ->
		super()

		@merge @_Ankerstab(10 * length)

		if special
			for b in special.split('/')
				c = b.split('=')
				if (c.length == 2)
					switch c[0].trim()
						when "RX"
							rot = -1 * parseFloat(c[1].trim())
							@applyMatrix4 Helpers.matrix(0, 0, 0, 'X', rot / 90)
						when "RZ"
							rot = -1 * parseFloat(c[1].trim())
							@applyMatrix4 Helpers.matrix(0, 0, 0, 'Y', rot / 90)
						when "RY"
							rot = -1 * parseFloat(c[1].trim())
							@applyMatrix4 Helpers.matrix(0, 0, 0, 'Z', rot / 90)
						else throw new Error('Drehung muss RX, RY oder RZ sein')

		@applyMatrix4 Helpers.matrix(10*x, 10*h, 10*y)

module.exports = Ankerstab
