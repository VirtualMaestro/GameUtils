/**
 Title:            Perlin noise
 Version:        1.2
 Author:            Ron Valstar
 Author URI:        http://www.sjeiti.com/
 Original code port from http://mrl.nyu.edu/~perlin/noise/
 and some help from http://freespace.virgin.net/hugo.elias/models/m_perlin.htm
 AS3 optimizations by Mario Klingemann http://www.quasimondo.com

 Next optimizations and refactoring made by VirtualMaestro in 11.07.2013
 Performance became faster for MXMLC around twice times and for ASC2.0 around 22%.
 */
package vm.math.rand
{
	import flash.display.BitmapData;

	/**
	 * Implementation of 3D perlin noise3d.
	 */
	final public class Noise
	{
		/**
		 */
		private static const p:Vector.<int> = new <int>[
			151, 160, 137, 91, 90, 15, 131, 13, 201, 95,
			96, 53, 194, 233, 7, 225, 140, 36, 103, 30, 69,
			142, 8, 99, 37, 240, 21, 10, 23, 190, 6, 148,
			247, 120, 234, 75, 0, 26, 197, 62, 94, 252,
			219, 203, 117, 35, 11, 32, 57, 177, 33, 88,
			237, 149, 56, 87, 174, 20, 125, 136, 171,
			168, 68, 175, 74, 165, 71, 134, 139, 48, 27,
			166, 77, 146, 158, 231, 83, 111, 229, 122,
			60, 211, 133, 230, 220, 105, 92, 41, 55, 46,
			245, 40, 244, 102, 143, 54, 65, 25, 63, 161,
			1, 216, 80, 73, 209, 76, 132, 187, 208, 89,
			18, 169, 200, 196, 135, 130, 116, 188, 159,
			86, 164, 100, 109, 198, 173, 186, 3, 64, 52,
			217, 226, 250, 124, 123, 5, 202, 38, 147, 118,
			126, 255, 82, 85, 212, 207, 206, 59, 227, 47,
			16, 58, 17, 182, 189, 28, 42, 223, 183, 170,
			213, 119, 248, 152, 2, 44, 154, 163, 70, 221,
			153, 101, 155, 167, 43, 172, 9, 129, 22, 39,
			253, 19, 98, 108, 110, 79, 113, 224, 232,
			178, 185, 112, 104, 218, 246, 97, 228, 251,
			34, 242, 193, 238, 210, 144, 12, 191, 179,
			162, 241, 81, 51, 145, 235, 249, 14, 239,
			107, 49, 192, 214, 31, 181, 199, 106, 157,
			184, 84, 204, 176, 115, 121, 50, 45, 127, 4,
			150, 254, 138, 236, 205, 93, 222, 114, 67, 29,
			24, 72, 243, 141, 128, 195, 78, 66, 215, 61,
			156, 180, 151, 160, 137, 91, 90, 15, 131, 13,
			201, 95, 96, 53, 194, 233, 7, 225, 140, 36,
			103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23,
			190, 6, 148, 247, 120, 234, 75, 0, 26, 197,
			62, 94, 252, 219, 203, 117, 35, 11, 32, 57,
			177, 33, 88, 237, 149, 56, 87, 174, 20, 125,
			136, 171, 168, 68, 175, 74, 165, 71, 134, 139,
			48, 27, 166, 77, 146, 158, 231, 83, 111, 229,
			122, 60, 211, 133, 230, 220, 105, 92, 41, 55,
			46, 245, 40, 244, 102, 143, 54, 65, 25, 63,
			161, 1, 216, 80, 73, 209, 76, 132, 187, 208,
			89, 18, 169, 200, 196, 135, 130, 116, 188,
			159, 86, 164, 100, 109, 198, 173, 186, 3, 64,
			52, 217, 226, 250, 124, 123, 5, 202, 38, 147,
			118, 126, 255, 82, 85, 212, 207, 206, 59,
			227, 47, 16, 58, 17, 182, 189, 28, 42, 223,
			183, 170, 213, 119, 248, 152, 2, 44, 154,
			163, 70, 221, 153, 101, 155, 167, 43, 172, 9,
			129, 22, 39, 253, 19, 98, 108, 110, 79, 113,
			224, 232, 178, 185, 112, 104, 218, 246, 97,
			228, 251, 34, 242, 193, 238, 210, 144, 12,
			191, 179, 162, 241, 81, 51, 145, 235, 249,
			14, 239, 107, 49, 192, 214, 31, 181, 199,
			106, 157, 184, 84, 204, 176, 115, 121, 50,
			45, 127, 4, 150, 254, 138, 236, 205, 93,
			222, 114, 67, 29, 24, 72, 243, 141, 128,
			195, 78, 66, 215, 61, 156, 180];

		private static var _numOctaves:int = 4;
		private static var _persistence:Number = 0.5;
		//
		private static var _octFrequency:Vector.<Number>; // frequency per octave
		private static var _octPersistence:Vector.<Number>; // persistence per octave
		private static var _maxPersistence:Number;// 1 / max persistence
		//
		private static var _seed:int = Math.random() * int.MAX_VALUE;

		private static var _offsetX:Number;
		private static var _offsetY:Number;
		private static var _offsetZ:Number;

		private static const baseFactor:Number = 1 / 64.0;

	   	//
		static private var _isInitFrequencyPersistence:Boolean = false;
		static private var _isInitSeed:Boolean = false;

		static private const B:int = 0x100;
		static private const BM:int = 0xff;
		static private const N:int = 0x1000;

		static private var _isNoise1dInit:Boolean = false;
		static private var _g1:Vector.<Number>;

		/**
		 */
		static public function perlin1d(p_value:Number):Number
		{
			if (!_isNoise1dInit) initPerlin1d();

			var t:Number = p_value + N;
			var bx0:int = int(t) & BM;
			var bx1:int = (bx0+1) & BM;
			var rx0:Number = t - int(t);
			var rx1:Number = rx0 - 1.0;
			var sx:Number = rx0 * rx0 * (3.0 - 2.0 * rx0);
            var u:Number = rx0 * _g1[ p[ bx0 ] ];
            var v:Number = rx1 * _g1[ p[ bx1 ] ];

            return u + sx * (v - u);
		}

		/**
		 */
		static private function initPerlin1d():void
		{
			_isNoise1dInit = true;

			_g1 = new <Number>[];
			for (var i:int = 0 ; i < B ; i++)
			{
				_g1[i] = Number(RandUtil.getIntRange(0, B + B) - B) / B;
			}

			for (i = 0 ; i < B + 2 ; i++)
			{
                _g1[B + i] = _g1[i];
            }
		}

		/**
		 * Simplex noise for 1d.
		 * Returns value on range [-1;1]
		 */
		public static function simplex1d(x:Number):Number
		{
			var i0:int = Math.floor(x);
			var i1:int = i0 + 1;
			var x0:Number = x - i0;
			var x1:Number = x0 - 1.0;
			var t0:Number = 1.0 - x0*x0;
			t0 *= t0;

			var n0:Number = t0 * t0 * grad(p[i0 & 0xff], x0);
			var t1:Number = 1.0 - x1*x1;
			t1 *= t1;

			var n1:Number = t1 * t1 * grad(p[i1 & 0xff], x1);
			// The maximum value of this noise is 8*(3/4)^4 = 2.53125
			// A factor of 0.395 scales to fit exactly within [-1,1]
			return 0.395 * (n0 + n1);
		}

		/**
		 */
		[Inline]
		private static function grad(hash:int, x:Number):Number
		{
			var h:int = hash & 15;
			var gradient:Number = 1.0 + (h & 7);   // Gradient value 1.0, 2.0, ..., 8.0
			if ((h & 8) != 0) gradient = -gradient;         // Set a random sign for the gradient
			return ( gradient * x );           // Multiply the gradient with the distance
		}


		/**
		 * Returns number on range [0; 1] by given params.
		 */
		public static function perlin3d(p_x:Number, p_y:Number = 1, p_z:Number = 1):Number
		{
			if (!isInitialized) init();

			var s:Number = 0;
			var fFreq:Number, fPers:Number, x:Number, y:Number, z:Number;
			var xf:Number, yf:Number, zf:Number, u:Number, v:Number, w:Number;
			var x1:Number, y1:Number, z1:Number;
			var X:int, Y:int, Z:int, A:int, B:int, AA:int, AB:int, BA:int, BB:int, hash:int;
			var g1:Number, g2:Number, g3:Number, g4:Number, g5:Number, g6:Number, g7:Number, g8:Number;

			p_x += _offsetX;
			p_y += _offsetY;
			p_z += _offsetZ;

			for (var i:int = 0; i < _numOctaves; i++)
			{
				fFreq = _octFrequency[i];
				fPers = _octPersistence[i];

				x = p_x * fFreq;
				y = p_y * fFreq;
				z = p_z * fFreq;

				xf = Math.floor(x);
				yf = Math.floor(y);
				zf = Math.floor(z);

				X = xf & 255;
				Y = yf & 255;
				Z = zf & 255;

				x -= xf;
				y -= yf;
				z -= zf;

				u = x * x * x * (x * (x * 6 - 15) + 10);
				v = y * y * y * (y * (y * 6 - 15) + 10);
				w = z * z * z * (z * (z * 6 - 15) + 10);

				A = p[X] + Y;
				AA = p[A] + Z;
				AB = p[A + 1] + Z;
				B = p[X + 1] + Y;
				BA = p[B] + Z;
				BB = p[B + 1] + Z;

				x1 = x - 1;
				y1 = y - 1;
				z1 = z - 1;

				//
				hash = p[BB + 1] & 15;
				g1 = getG(hash, x1, y1, z1);

				hash = p[AB + 1] & 15;
				g2 = getG(hash, x, y1, z1);

				hash = p[BA + 1] & 15;
				g3 = getG(hash, x1, y, z1);

				hash = p[AA + 1] & 15;
				g4 = getG(hash, x, y, z1);

				hash = p[BB] & 15;
				g5 = getG(hash, x1, y1, z);

				hash = p[AB] & 15;
				g6 = getG(hash, x, y1, z);

				hash = p[BA] & 15;
				g7 = getG(hash, x1, y, z);

				hash = p[AA] & 15;
				g8 = getG(hash, x, y, z);

				//
				g2 += u * (g1 - g2);
				g4 += u * (g3 - g4);
				g6 += u * (g5 - g6);
				g8 += u * (g7 - g8);

				g4 += v * (g2 - g4);
				g8 += v * (g6 - g8);

				s += ( g8 + w * (g4 - g8)) * fPers;
			}

			return ( s * _maxPersistence + 1 ) * 0.5;
		}

		/**
		 */
		[Inline]
		static private function getG(p_hash:int, p_x:Number, p_y:Number, p_z:Number):Number
		{
			var gE_1:Number;
			var gE_2:Number;

			// gE_1
			if ((p_hash & 1) == 0)
			{
				if (p_hash < 8) gE_1 = p_x;
				else gE_1 = p_y;
			}
			else
			{
				if (p_hash < 8) gE_1 = -p_x;
				else gE_1 = -p_y;
			}

			// gE_2
			if ((p_hash & 2) == 0)
			{
				if (p_hash < 4) gE_2 = p_y;
				else
				{
					if (p_hash == 12) gE_2 = p_x;
					else gE_2 = p_z;
				}
			}
			else
			{
				if (p_hash < 4) gE_2 = -p_y;
				else
				{
					if (p_hash == 14) gE_2 = -p_x;
					else gE_2 = -p_z;
				}
			}

			return gE_1 + gE_2;
		}

		/**
		 * Fill bitmap of perlin noise3d.
		 */
		public static function fill(p_bitmap:BitmapData, p_x:Number = 0, p_y:Number = 0, p_z:Number = 0):void
		{
			if (!isInitialized) init();

			var s:Number = 0;
			var fFreq:Number, fPers:Number, x:Number, y:Number, z:Number;
			var xf:Number, yf:Number, zf:Number, u:Number, v:Number, w:Number;
			var x1:Number, y1:Number, z1:Number, baseX:Number, px:int, py:int;
			var i:int, X:int, Y:int, Z:int, A:int, B:int, AA:int, AB:int, BA:int, BB:int, hash:int;
			var g1:Number, g2:Number, g3:Number, g4:Number, g5:Number, g6:Number, g7:Number, g8:Number;
			var color:int;

			baseX = p_x * baseFactor + _offsetX;
			p_y = p_y * baseFactor + _offsetY;
			p_z = p_z * baseFactor + _offsetZ;

			var width:int = p_bitmap.width;
			var height:int = p_bitmap.height;

			for (py = 0; py < height; py++)
			{
				p_x = baseX;

				for (px = 0; px < width; px++)
				{
					s = 0;

					for (i = 0; i < _numOctaves; i++)
					{
						fFreq = _octFrequency[i];
						fPers = _octPersistence[i];

						x = p_x * fFreq;
						y = p_y * fFreq;
						z = p_z * fFreq;

						xf = Math.floor(x);
						yf = Math.floor(y);
						zf = Math.floor(z);

						X = xf & 255;
						Y = yf & 255;
						Z = zf & 255;

						x -= xf;
						y -= yf;
						z -= zf;

						u = x * x * x * (x * (x * 6 - 15) + 10);
						v = y * y * y * (y * (y * 6 - 15) + 10);
						w = z * z * z * (z * (z * 6 - 15) + 10);

						A = p[X] + Y;
						AA = p[A] + Z;
						AB = p[A + 1] + Z;
						B = p[X + 1] + Y;
						BA = p[B] + Z;
						BB = p[B + 1] + Z;

						x1 = x - 1;
						y1 = y - 1;
						z1 = z - 1;

						//
						hash = p[BB + 1] & 15;
						g1 = getG(hash, x1, y1, z1);

						hash = p[AB + 1] & 15;
						g2 = getG(hash, x, y1, z1);

						hash = p[BA + 1] & 15;
						g3 = getG(hash, x1, y, z1);

						hash = p[AA + 1] & 15;
						g4 = getG(hash, x, y, z1);

						hash = p[BB] & 15;
						g5 = getG(hash, x1, y1, z);

						hash = p[AB] & 15;
						g6 = getG(hash, x, y1, z);

						hash = p[BA] & 15;
						g7 = getG(hash, x1, y, z);

						hash = p[AA] & 15;
						g8 = getG(hash, x, y, z);

						//
						g2 += u * (g1 - g2);
						g4 += u * (g3 - g4);
						g6 += u * (g5 - g6);
						g8 += u * (g7 - g8);

						g4 += v * (g2 - g4);
						g8 += v * (g6 - g8);

						s += ( g8 + w * (g4 - g8)) * fPers;
					}

					color = ( s * _maxPersistence + 1 ) * 128;
					p_bitmap.setPixel32(px, py, 0xff000000 | color << 16 | color << 8 | color);

					p_x += baseFactor;
				}

				p_y += baseFactor;
			}
		}

		/**
		 */
		public static function get numOctaves():int
		{
			return _numOctaves;
		}

		/**
		 * Sets num octaves.
		 */
		public static function set numOctaves(p_octaves:int):void
		{
			if (_numOctaves == p_octaves) return;
			_numOctaves = p_octaves;
			_isInitFrequencyPersistence = false;
		}

		/**
		 */
		public static function get falloff():Number
		{
			return _persistence;
		}

		/**
		 */
		public static function set falloff(p_persistence:Number):void
		{
			if (_persistence == p_persistence) return;
			_persistence = p_persistence;
			_isInitFrequencyPersistence = false;
		}

		/**
		 */
		public static function get seed():Number
		{
			return _seed;
		}

		/**
		 */
		public static function set seed(p_seed:Number):void
		{
			if (_seed == p_seed) return;
			_seed = p_seed;
			_isInitSeed = false;
		}

		/**
		 * Should to call if need prepare perlin noise3d before use.
		 * But it is not necessary, with first call of 'noise3d' method, everything will be prepared automatically.
		 */
		public static function init():void
		{
			if (!_isInitSeed) seedOffset();
			if (!_isInitFrequencyPersistence) prepareFrequencyPersistence();

			_isInitSeed = true;
			_isInitFrequencyPersistence = true;
		}

		/**
		 */
		[Inline]
		static private function get isInitialized():Boolean
		{
			return _isInitFrequencyPersistence && _isInitSeed;
		}

		/**
		 */
		private static function prepareFrequencyPersistence():void
		{
			var frequency:Number;
			var persistence:Number;

			_octFrequency = new <Number>[];
			_octPersistence = new <Number>[];
			_maxPersistence = 0;

			for (var i:int=0; i < _numOctaves; i++)
			{
				frequency = Math.pow(2, i);
				persistence = Math.pow(_persistence, i);
				_maxPersistence += persistence;
				_octFrequency[i] = frequency;
				_octPersistence[i] = persistence;
			}

			_maxPersistence = 1 / _maxPersistence;
		}

		/**
		 */
		private static function seedOffset():void
		{
			_offsetX = _seed = (_seed * 16807) % 2147483647;
			_offsetY = _seed = (_seed * 16807) % 2147483647;
			_offsetZ = _seed = (_seed * 16807) % 2147483647;
		}
	}
}