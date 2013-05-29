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
			return min + (_pSeedUint >>> 16) * (1.0 / 65535.0) * (max - min);
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
	}
}