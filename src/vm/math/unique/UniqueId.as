package vm.math.unique
{
	import flash.utils.getTimer;

	/**
	 * Класс предназначен для генерации уникального id или имени.
	 *
	 * @author VirtualMaestro
	 */
	public class UniqueId
	{
		private static var _uniqueId:int = 0;

		/**
		 * Возвращает уникальный номер (id)
		 */
		public static function getId():int
		{
			_uniqueId++;
			return _uniqueId;
		}

		/**
		 * Возвращает уникальное имя.
		 * К заданному имени добавляет в конце числовое значение.
		 */
		static public function getUniqueName(p_patternName:String):String
		{
			p_patternName += "_" + (getTimer() + getId());
			return p_patternName;
		}
	}
}