package vm.math.numbers
{
	/**
	 *
	 */
	public class NumberUtil
	{
		/**
		 * Определяет является ли число четным.
		 */
		static public function isEven(number:Number):Boolean
		{
			return ((number & 1) == 0);
		}

		/**
		 * Вычисляет знак заданного числа.
		 *
		 * @param value - Заданное число
		 * @return Возвращает -1.0 если заданное число меньше нуля (value < 0) или 1.0 если число больше или равно нулю (value >=0.0) .
		 */
		static public function sign(value:Number):Number
		{
			return (1.0 - (int(value < 0.0) << 1));
		}

		/**
		 * Возвращает минимальное число из двух заданных.
		 *
		 * @param value0
		 * @param value1
		 * @return Возвращает найменьшее число из двух заданных (value0 и value1).
		 */
		static public function min(value0:Number, value1:Number):Number
		{
			return value0 < value1 ? value0 : value1;
		}

		/**
		 * Возвращает большее число из двух заданных.
		 *
		 * @param value0 - первый параметр
		 * @param value1 - второй параметр
		 * @return Возврат. большее из двух заданных - value0 и value1
		 */
		static public function max(value0:Number, value1:Number):Number
		{
			return (value0 > value1) ? value0 : value1;
		}

		/**
		 * Приведения Number к Int в соответствии с дробовой частью и учетом знака.
		 * Примеры:
		 * - если value=1.3 то результат будет 1;
		 * - если value=1.5 то результат будет 2;
		 * - если value=-1.5 то результат будет -2;
		 * - если value=-1.3 то результат будет -1;
		 *
		 * @param value заданное число.
		 * @return Приведенно число.
		 */
		static public function rint(value:Number):int
		{
			return int(value + 0.5 - Number(value < 0));
		}

		/**
		 * Проверяет является ли заданное значение не числом :)
		 */
		static public function isNaN(n:Object):Boolean
		{
			return n != n;
		}

		/**
		 * Проверяет являются ли два заданных числа одинаковыми до заданной точности.
		 */
		static public function isEqual(p_val1:Number, p_val2:Number, p_precis:Number = 0.001):Boolean
		{
			return Math.abs(p_val1 - p_val2) < p_precis;
		}

		////////
		static private var periodTable:Array = [];

		{
			static private var i:int = 0;
			for (i = 0; i < 10; i++)
			{
				periodTable[i] = Math.pow(10, i);
			}
		}

		/**
		 * Метод округляет данное число до заданного знака после запятой.
		 * p_period - количество цифр после запятой. Возможные значения от 0 - 9.
		 */
		static public function round(p_number:Number, p_period:int = 3):Number
		{
			p_period = periodTable[p_period];
			return Math.round(p_number * p_period) / p_period;
		}
	}
}
