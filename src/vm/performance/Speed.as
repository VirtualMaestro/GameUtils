/**
 * User: VirtualMaestro
 * Date: 19.04.12
 * Time: 10:48
 */
package vm.performance
{
	import flash.utils.getTimer;

	/**
	 * You can measure speed of performance some methods.
	 */
	public class Speed
	{
		static private var _testsTable:Array = [];

		/**
		 * Start measure performance speed.
		 * testName - should be unique for different tests.
		 */
		static public function start(testName:String = "testName"):int
		{
			var startTime:int = getTimer();
			_testsTable[testName] = startTime;

			return startTime;
		}

		/**
		 * Finishes measuring of performance.
		 */
		static public function end(testName:String = "testName"):int
		{
			return getTimer() - _testsTable[testName];
		}
	}
}
