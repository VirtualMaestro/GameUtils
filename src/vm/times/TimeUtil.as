package vm.times
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 *
	 */
	public class TimeUtil
	{

		/**
		 * Returns timer instance. If autoStart == true, timer starts immediately after creation.
		 */
		static public function getTimer(listener:Function, delay:uint = 1000, repeatCount:uint = 0, autoStart:Boolean = true):Timer
		{
			var timer:Timer = new Timer(delay, repeatCount);
			timer.addEventListener(TimerEvent.TIMER, listener);
			if (autoStart) timer.start();

			return timer;
		}
	}
}
