THREE = require "THREE"
{ Helpers } = require "../Helpers"
Common = require "../Common"

class Flanschmutter extends THREE.Geometry

	_Flanschmutter: (up = 1) ->
		f = new THREE.Geometry
		f.merge Helpers.cylinder(25, 0, 40)
		f.merge Helpers.cylinder(80, 0, 10)
		if up is 1
			f.translate(0, 0, 10)
			unterlagsplatte = new THREE.BoxGeometry(100, 100, 10)
			unterlagsplatte.translate(0, 0, 5)
			f.merge unterlagsplatte
		f.applyMatrix4 Helpers.matrix(0,0,0, 'Y', 1)
		f.applyMatrix4 Helpers.matrix(0,0,0, 'X', -1)
		f

	constructor: (x, y, h, special) ->
		super()

		up = 1
		if special
			for s in special.split '/'
				up = 0 if s[0] is 'o'

		@merge @_Flanschmutter(up)

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

module.exports = Flanschmutter
