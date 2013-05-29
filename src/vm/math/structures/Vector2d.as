/**
 * Created by JetBrains Astella.
 * User: VirtualMaestro
 * Date: 14.02.12
 * Time: 19:11
 */
package vm.math.structures
{
	public class Vector2d
	{
		// Просто для сохранения какого нибудь числового дополнительного значения (напр. используется в алгоритме упорядочивания точек)
		public var value:Number = 0;

		public var x:Number = 0;
		public var y:Number = 0;

		public function Vector2d(x:Number = 0.0, y:Number = 0.0)
		{
			this.x = x;
			this.y = y;
		}

		public function setxy(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}

		/**
		 * Добавляет значение заданного вектора к текущему.
		 */
		public function add(vec:Vector2d):void
		{
			this.x += vec.x;
			this.y += vec.y;
		}

		/**
		 * Вычитает значение заданного вектора к текущему.
		 */
		public function sub(vec:Vector2d):void
		{
			this.x -= vec.x;
			this.y -= vec.y;
		}

		public function copy():Vector2d
		{
			var copyVec:Vector2d = new Vector2d(x, y);
			return copyVec;
		}
	}
}
