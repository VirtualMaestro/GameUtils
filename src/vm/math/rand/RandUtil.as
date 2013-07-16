package vm.math.rand
{
	/**
	 * Random numbers util.
	 */
	public class RandUtil
	{
		static private const MAX_RATIO_INT:Number = 1 / int.MAX_VALUE;
		static private const NEGA_MAX_RATIO:Number = -MAX_RATIO_INT;
		static private const MAX_RATIO_UINT:Number = 1 / uint.MAX_VALUE;
		static private const ONE_div_65535:Number = 1.0/65535.0;

		static private var _pSeedUint:uint = uint(Math.random() * uint.MAX_VALUE);
		static private var _pSeedInt:int = Math.random() * int.MAX_VALUE;

		/**
		 */
		static public function set seed(val:uint):void
		{
			if (val != 0) _pSeedUint = val;
		}

		/**
		 */
		static public function get seed():uint
		{
			return _pSeedUint;
		}

		/**
		 * Method returns rand integer number in given range.
		 */
		static public function getIntRange(min:int, max:int):int
		{
			_pSeedUint = 214013 * _pSeedUint + 2531011;
			return min + (_pSeedUint ^ (_pSeedUint >> 15)) % (max - min + 1);
		}

		/**
		 * returns un sign int between [0; uint.MAX_VALUE]
		 */
		static public function getIntUnsigned():uint
		{
			_pSeedUint ^= (_pSeedUint << 21);
			_pSeedUint ^= (_pSeedUint >>> 35);
			_pSeedUint ^= (_pSeedUint << 4);

			return _pSeedUint;
		}

		/**
		 *
		 */
		public static function getRandRange(min:Number,max:Number=NaN):Number
		{
			return Math.random()*(max-min)+min;
		}

		/**
		 * Method returns rand float number in given range.
		 */
		static public function getFloatRange(min:Number, max:Number):Number
		{
			_pSeedUint = 214013 * _pSeedUint + 2531011;
			return min + (_pSeedUint >>> 16) * ONE_div_65535 * (max - min);
		}

		/**
		 *  Method returns rand float number on range (-1 > x < 1)
		 */
		static public function getFloat():Number
		{
			_pSeedInt ^= (_pSeedInt << 21);
			_pSeedInt ^= (_pSeedInt >>> 35);
			_pSeedInt ^= (_pSeedInt << 4);

			return _pSeedInt * NEGA_MAX_RATIO;
		}

		/**
		 * Method returns rand float number on range (0 < x < 1)
		 */
		static public function getFloatUnsigned():Number
		{
			_pSeedUint ^= (_pSeedUint << 21);
			_pSeedUint ^= (_pSeedUint >>> 35);
			_pSeedUint ^= (_pSeedUint << 4);

			return _pSeedUint * MAX_RATIO_UINT;
		}

		//
		static private var _phase:Boolean = true;
		static private var _v1:Number, _v2:Number, _r:Number, _m:Number;

		/**
		 * Returns random number by Gaussian distribution.
		 * Returns number between [-infinity; +infinity], but 99.7% returned number lies on range [-3;3]
		 * p_mean - mean
		 * p_sigma - standard deviation
		 *
		 * If need strictly in some range need to reject numbers out of range [-3;3].
		 *
		 * If need to get in range (-1;1), should to set p_mean = 0, p_sigma = 1.0/3.0
		 * If need to get in range (0;1), should to set p_mean = 0.5, p_sigma = 0.5/3.0
		 */
		static public function getGaussian(p_mean:Number = 0.0, p_sigma:Number = 1.0):Number
		{
			var z:Number;

			if(_phase)
			{
				do
				{
					_v1 = getFloatUnsigned();
					_v2 = getFloatUnsigned();
					_v1 = _v1*2 - 1;
					_v2 = _v2*2 - 1;
					_r = _v1*_v1 + _v2*_v2;
				}
				while(_r >= 1 || _r == 0);

				_m = Math.sqrt(-2 * Math.log(_r) / _r);
				z = _v1 * _m;
			}
			else z = _v2 * _m;

			_phase = !_phase;

			return z*p_sigma + p_mean;
		}
	}
}