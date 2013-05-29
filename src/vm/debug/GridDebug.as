/**
 * User: VirtualMaestro
 * Date: 21.03.13
 * Time: 18:52
 */
package vm.debug
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * Represent visual grid for debugging.
	 */
	public class GridDebug extends Sprite
	{
		//p_width:int, p_height:int, p_cellSize:int = 50, p_fontSize:int = 12,
		// p_textColor:uint = 0xffffff, p_gridColor:uint = 0x000000, p_lineThikness:int = 1, p_nodeColor:uint = 0x123456

		private var _width:int;
		private var _height:int;
		private var _cellSize:int;
		private var _fontSize:int;
		private var _textColor:int;
		private var _gridColor:int;
		private var _nodeColor:int;
		private var _lineThickness:int;

		private var _labels:Array;

		/**
		 */
		public function GridDebug(p_width:int, p_height:int, p_cellSize:int = 50, p_fontSize:int = 12, p_textColor:uint = 0xffffff, p_gridColor:uint = 0x000000, p_lineThickness:int = 1, p_nodeColor:uint = 0x123456)
		{
			_width = p_width;
			_height = p_height;
			_cellSize = p_cellSize;
			_fontSize = p_fontSize;
			_textColor = p_textColor;
			_gridColor = p_gridColor;
			_lineThickness = p_lineThickness;
			_nodeColor = p_nodeColor;

			_labels = [];

			update();
		}

		/**
		 */
		private function update():void
		{
			var gr:Graphics = graphics;
			gr.lineStyle(_lineThickness, _gridColor);

			var iterX:int = _width / _cellSize;
			var iterY:int = _height / _cellSize;
			var xp:Number = 0;
			var yp:Number = 0;
			var coords:TextField;

			var needLabels:int = iterX * iterY;
			if (needLabels > _labels.length)
			{
				needLabels = needLabels - _labels.length;
				for (var k:int = 0; k < needLabels; k++)
				{
					coords = DebugUtil.getTextField(_fontSize, _textColor);
					coords.border = false;
					coords.selectable = false;
					coords.mouseEnabled = false;

					_labels.push(coords);
				}
			}

			var labelIterator:int = 0;

			for (var i:int = 0; i < iterY; i++)
			{
				for (var j:int = 0; j < iterX; j++)
				{
					gr.moveTo(xp, yp);
					gr.lineTo(xp + _cellSize, yp);
					gr.lineTo(xp + _cellSize, yp + _cellSize);
					gr.lineTo(xp, yp + _cellSize);
					gr.lineTo(xp, yp);

					coords = _labels[labelIterator];
					coords.text = "(" + xp + ", " + yp + ")";
					coords.x = xp;
					coords.y = yp;
					if (!coords.parent) addChild(coords);

					var node:Sprite = DebugUtil.getPointSprite(2, _nodeColor);
					addChild(node);
					node.x = xp;
					node.y = yp;

					xp += _cellSize;
					labelIterator++;
				}

				xp = 0;
				yp += _cellSize;
			}
		}

		/**
		 * Set size of grid.
		 */
		public function setSize(p_width:int, p_height:int):void
		{
			_width = p_width;
			_height = p_height;

			update();
		}

		public function get cellSize():int
		{
			return _cellSize;
		}

		public function set cellSize(p_value:int):void
		{
			_cellSize = p_value;
			update();
		}

		public function get fontSize():int
		{
			return _fontSize;
		}

		public function set fontSize(p_value:int):void
		{
			_fontSize = p_value;
		}

		public function get textColor():int
		{
			return _textColor;
		}

		public function set textColor(p_value:int):void
		{
			_textColor = p_value;
		}

		public function get gridColor():int
		{
			return _gridColor;
		}

		public function set gridColor(p_value:int):void
		{
			_gridColor = p_value;
			update();
		}

		public function get nodeColor():int
		{
			return _nodeColor;
		}

		public function set nodeColor(p_value:int):void
		{
			_nodeColor = p_value;
			update();
		}

		public function get lineThickness():int
		{
			return _lineThickness;
		}

		public function set lineThickness(p_value:int):void
		{
			_lineThickness = p_value;
			update();
		}
	}
}
