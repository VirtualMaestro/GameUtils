package vm.debug
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class DebugUtil
	{
		/**
		 * Returns graphics rectangle with given color.
		 * alignByCenter - if true graphics aligns by center of rectangle, in another case aligns by left-top corner.
		 */
		static public function getRectSprite(width:Number, height:Number, color:Number = 0xff0000, alignByCenter:Boolean = false):Sprite
		{
			var x:Number = 0;
			var y:Number = 0;

			if (alignByCenter)
			{
				x = -width / 2;
				y = -height / 2;
			}

			var rect:Sprite = new Sprite();
			var graphics:Graphics = rect.graphics;
			graphics.beginFill(color);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();

			return rect;
		}

		/**
		 * Returns graphics circle with given color.
		 * alignByCenter - if true graphics aligns by center of circle, in another case aligns by left-top corner.
		 */
		static public function getCircleSprite(radius:Number, color:Number = 0xff0000, alignByCenter:Boolean = false):Sprite
		{
			var x:Number = 0;
			var y:Number = 0;

			if (alignByCenter)
			{
				x = -radius / 2;
				y = -radius / 2;
			}

			var circle:Sprite = new Sprite();
			var graphics:Graphics = circle.graphics;
			graphics.beginFill(color);
			graphics.drawCircle(x, y, radius);
			graphics.endFill();

			return circle;
		}

		/**
		 * Returns sprite with drawn point of  given radius and color.
		 */
		static public function getPointSprite(radius:int = 5, color:uint = 0xff0000):Sprite
		{
			var point:Sprite = new Sprite();
			var gr:Graphics = point.graphics;
			gr.beginFill(color);
			gr.drawCircle(0, 0, radius);
			gr.endFill();

			point.mouseChildren = false;
			point.mouseEnabled = false;

			return point;
		}

		/**
		 * Returns textField with a given parameters.
		 */
		static public function getTextField(p_fontSize:int = 14, p_textColor:uint = 0x000000, p_width:int = 200, p_height:int = 100, p_autoSize:Boolean = true):TextField
		{
			var textField:TextField = new TextField();

			var textFormat:TextFormat = textField.defaultTextFormat;
			textFormat.size = p_fontSize;
			textField.defaultTextFormat = textFormat;
			textField.width = p_width;
			textField.height = p_height;
			textField.textColor = p_textColor;

			if (p_autoSize)
			{
				textField.autoSize = TextFieldAutoSize.LEFT;
			}

			textField.wordWrap = false;
			textField.border = true;

			return textField;
		}

		/**
		 * Returns sprite as button with given parameters.
		 */
		static public function getButton(label:String, fontSize:int = 16, color:uint = 0x0000ff):Sprite
		{
			const PADDING:int = 10;

			var button:Sprite = new Sprite();
			button.mouseChildren = false;
			button.useHandCursor = true;
			button.buttonMode = true;

			var background:Sprite = new Sprite();
			button.addChild(background);

			var mouseOverFunc:Function = function (event:MouseEvent = null):void
			{
				var gr:Graphics = background.graphics;
				gr.beginFill(color / 3);
				gr.drawRoundRect(0, 0, (PADDING * 2 + labelField.width), (PADDING * 2 + labelField.height), 10, 10);
				gr.endFill();
			};

			var mouseOutFunc:Function = function (event:MouseEvent = null):void
			{
				var gr:Graphics = background.graphics;
				gr.beginFill(color);
				gr.drawRoundRect(0, 0, (PADDING * 2 + labelField.width), (PADDING * 2 + labelField.height), 10, 10);
				gr.endFill();
			};

			button.addEventListener(MouseEvent.MOUSE_OVER, mouseOverFunc);
			button.addEventListener(MouseEvent.MOUSE_OUT, mouseOutFunc);

			var labelField:TextField = getTextField(fontSize);
			button.addChild(labelField);
			labelField.text = label;
			labelField.textColor = 0xffffff;
			labelField.border = false;

			mouseOutFunc();

			labelField.x = button.width / 2 - labelField.width / 2;
			labelField.y = button.height / 2 - labelField.height / 2;

			return button;
		}

		/**
		 */
		static public function getGrid(p_width:uint = 800, p_height:uint = 600, p_cellSize:uint = 50, p_fontSize:uint = 10, p_textColor:uint = 0x000000, p_gridColor:uint = 0xff0000, p_lineThickness:uint = 1, p_nodeColor:uint = 0x00ff00):Sprite
		{
			var grid:Sprite = new Sprite();
			var gr:Graphics = grid.graphics;
			gr.lineStyle(p_lineThickness, p_gridColor);

			var iterX:int = p_width / p_cellSize;
			var iterY:int = p_height / p_cellSize;
			var x:Number = 0;
			var y:Number = 0;
			var coords:TextField;

			for (var i:int = 0; i < iterY; i++)
			{
				for (var j:int = 0; j < iterX; j++)
				{
					gr.moveTo(x, y);
					gr.lineTo(x + p_cellSize, y);
					gr.lineTo(x + p_cellSize, y + p_cellSize);
					gr.lineTo(x, y + p_cellSize);
					gr.lineTo(x, y);

					coords = getTextField(p_fontSize, p_textColor);
					coords.text = "(" + x + ", " + y + ")";
					coords.border = false;
					coords.x = x;
					coords.y = y;
					coords.selectable = false;
					coords.mouseEnabled = false;

					grid.addChild(coords);
					var node:Sprite = getPointSprite(2, p_nodeColor);
					grid.addChild(node);
					node.x = x;
					node.y = y;

					x += p_cellSize;
				}

				x = 0;
				y += p_cellSize;
			}

			return grid;
		}

		// TODO: Add tooltip
	}
}
