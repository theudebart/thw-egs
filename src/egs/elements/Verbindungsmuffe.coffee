THREE = require "THREE"
{ Helpers } = require "../Helpers"

class Verbindungsmuffe extends THREE.Geometry

	_Verbindungsmuffe: ->
		v = new THREE.Geometry
		v.merge Helpers.cylinder(20, 15, 100)
		v.applyMatrix4 Helpers.matrix(0,0,0, 'Y', 1)
		v.applyMatrix4 Helpers.matrix(0,0,0, 'X', -1)
		v

	constructor: (x, y, h, special) ->
		super()

		@merge @_Verbindungsmuffe()

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

module.exports = Verbindungsmuffe
