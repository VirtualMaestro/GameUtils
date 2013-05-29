/**
 * User: VirtualMaestro
 * Date: 07.02.13
 * Time: 18:42
 */
package vm.colors
{
	/**
	 * Manipulates with colors.
	 */
	public class ColorUtil
	{
		/**
		 * Convert ARGB to HEX representation.
		 */
		static public function argbToHex(p_alpha:uint, p_red:uint, p_green:uint, p_blue:uint):uint
		{
			return p_alpha << 24 | p_red << 16 | p_green << 8 | p_blue;
		}

		/**
		 * Convert HEX to ARGB.
		 */
		static public function hexToARGB(hex:Number):Object
		{
			var color:ColorARGB = new ColorARGB();
			color.alpha = (hex & 0xFF000000) >> 24;
			color.red = (hex & 0x00FF0000) >> 16;
			color.green = (hex & 0x0000FF00) >> 8;
			color.blue = hex & 0x000000FF;

			return color;
		}
	}
}
