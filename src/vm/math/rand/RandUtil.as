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

		static public function get seed():uint
		{
			return _pSeedUint;
		}

		/**
		 * Возвращает целое число в заданном диапазоне
		 */
		static public function getIntRange(min:int, max:int):int
		{
			_pSeedUint = 214013 * _pSeedUint + 2531011;
			return min + (_pSeedUint ^ (_pSeedUint >> 15)) % (max - min + 1);
		}

		/**
		 * Возвращает дробное число в заданном диапазоне
		 */
		static public function getFloatRange(min:Number, max:Number):Number
		{
			_pSeedUint = 214013 * _pSeedUint + 2531011;
			return min + (_pSeedUint >>> 16) * ONE_div_65535 * (max - min);
		}

		/**
		 *  Метод возвращает случайное число на промежутке [-1; 1]
		 */
		static public function getFloat():Number
		{
			_pSeedInt ^= (_pSeedInt << 21);
			_pSeedInt ^= (_pSeedInt >>> 35);
			_pSeedInt ^= (_pSeedInt << 4);

			return _pSeedInt * NEGA_MAX_RATIO;
		}

		/**
		 * Метод возвращает случайное число на промежутке [0; 1]
		 */
		static public function getFloatUnsign():Number
		{
			_pSeedUint ^= (_pSeedUint << 21);
			_pSeedUint ^= (_pSeedUint >>> 35);
			_pSeedUint ^= (_pSeedUint << 4);

			return (_pSeedUint * MAX_RATIO_UINT);
		}

		//
		static private var _phase:Boolean = true;
		static private var V1:Number, V2:Number, R:Number;

		/**
		 * Returns random number between 0 and 1. (Gaussian distribution).
		 */
		static public function getFloatG():Number
		{
			var Z:Number;

			if(_phase)
			{
				do
				{
					V1 = getFloatUnsign();
					V2 = getFloatUnsign();
					V1 = V1*2 - 1;
					V2 = V2*2 - 1;
					R = V1*V1 + V2*V2;
				}
				while(R >= 1 || R <= 0);

				Z = V1 * Math.sqrt(-2 * Math.log(R) / R);
			}
			else Z = V2 * Math.sqrt(-2 * Math.log(R) / R);

			if (Z > 1 || Z < 0) Z = Math.abs(Z % 1);
			_phase = !_phase;

			return Z;
		}
	}
}