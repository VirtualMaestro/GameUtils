package vm.math.trigonometry
{
	import flash.geom.Point;

	/**
	 *
	 */
	public class TrigUtil
	{
		/**
		 * Константа перевода радиан в градусы.
		 * Приблизительно 57.295779513082320876798154814105
		 */
		static public const RAD_TO_DEG:Number = 180.0 / Math.PI;

		/**
		 * Константа перевода градусов в радианы.
		 * Приблизительно 0,017453292519943295769236907684886
		 */
		static public const DEG_TO_RAD:Number = Math.PI / 180.0;

		/**
		 */
		static public const PI:Number = Math.PI;

		/**
		 * Константа PI * 2
		 */
		static public const PI2:Number = Math.PI * 2;

		/**
		 * Метод вычисляет угол между двумя заданными точками.
		 *
		 * @param    x1 - координата Х первой точки.
		 * @param    y1 - координата Y первой точки.
		 * @param    x2 - координата Х второй точки.
		 * @param    y2 - координата Y второй точки.
		 * @return - Возвращает угол в градусах.
		 */
		static public function getAnglePointsDeg(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var x:Number = x2 - x1;
			var y:Number = y2 - y1;

			return Math.atan2(y, x) * RAD_TO_DEG;
		}

		/**
		 * Метод вычисляет угол между двумя заданными точками.
		 *
		 * @param    x1 - координата Х первой точки.
		 * @param    y1 - координата Y первой точки.
		 * @param    x2 - координата Х второй точки.
		 * @param    y2 - координата Y второй точки.
		 * @return - Возвращает угол в радианах.
		 */
		static public function getAnglePointsRad(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var x:Number = x2 - x1;
			var y:Number = y2 - y1;

			return Math.atan2(y, x);
		}

		/**
		 * Возвращает угол в радианах между двумя заданными линиями.
		 * Чтобы получить угол в градусах умножьте полученное значение на константу RAD_TO_DEG.
		 */
		static public function getAngleLines(startLine1:Point, endLine1:Point, startLine2:Point, endLine2:Point):Number
		{
			var x1:Number = endLine1.x - startLine1.x;
			var y1:Number = endLine1.y - startLine1.y;
			var x2:Number = endLine2.x - startLine2.x;
			var y2:Number = endLine2.y - startLine2.y;

			return Math.acos((x1 * x2 + y1 * y2) / Math.sqrt((x1 * x1 + y1 * y1) * (x2 * x2 + y2 * y2)));
		}

		/**
		 * Возвращает косинус альфа между двумя заданными линиями.
		 * Метод такой же как getAngleLines за исключением того, что не вычисляется арккосинус, тем самым не возвращает угла в радианах.
		 * Метод может быть полезным когда нет необходимости знать углы, но надо узнать является ли один потенциальный угл больше/меньше другого.
		 * Чем значение меньше тем угол больше.
		 * Так как в отличии от getAngleLines метод не рассчитывает арккосинус работает быстрее.
		 */
		static public function getCosALines(startLine1:Point, endLine1:Point, startLine2:Point, endLine2:Point):Number
		{
			var x1:Number = endLine1.x - startLine1.x;
			var y1:Number = endLine1.y - startLine1.y;
			var x2:Number = endLine2.x - startLine2.x;
			var y2:Number = endLine2.y - startLine2.y;

			return (x1 * x2 + y1 * y2) / Math.sqrt((x1 * x1 + y1 * y1) * (x2 * x2 + y2 * y2));
		}

		/**
		 * Метод вычисляет расстояние между точками.
		 *
		 * @param    x1 - координата Х первой точки.
		 * @param    y1 - координата Y первой точки.
		 * @param    x2 - координата Х второй точки.
		 * @param    y2 - координата Y второй точки.
		 *
		 * @return - Возвращает число - расстояние между точками.
		 */
		static public function getDistance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var xd:Number = x1 - x2;
			var yd:Number = y1 - y2;

			return Math.sqrt(xd * xd + yd * yd);
		}

		/**
		 * Возвращает точку пересечения двух линий.
		 */
		static public function getIntersectLines(p1:Point, p2:Point, p3:Point, p4:Point):Point
		{
			var p1x:Number = p1.x;
			var p1y:Number = p1.y;
			var p2x:Number = p2.x;
			var p2y:Number = p2.y;
			var p3x:Number = p3.x;
			var p3y:Number = p3.y;
			var p4x:Number = p4.x;
			var p4y:Number = p4.y;

			var p1xSp2x:Number = p1x - p2x;
			var p1ySp2y:Number = p1y - p2y;
			var p1xSp3x:Number = p1x - p3x;
			var p1ySp3y:Number = p1y - p3y;
			var p4xSp3x:Number = p4x - p3x;
			var p4ySp3y:Number = p4y - p3y;

			var d:Number = p1xSp2x * p4ySp3y - p1ySp2y * p4xSp3x;
			var da:Number = p1xSp3x * p4ySp3y - p1ySp3y * p4xSp3x;
			var db:Number = p1xSp2x * p1ySp3y - p1ySp2y * p1xSp3x;

			var ta:Number = da / d;
			var tb:Number = db / d;

			if (ta >= 0)
			{
				if (ta <= 1)
				{
					if (tb >= 0)
					{
						if (tb <= 1)
						{
							var dx:Number = p1x + ta * (p2x - p1x);
							var dy:Number = p1y + ta * (p2y - p1y);

							return new Point(dx, dy);
						}
					}
				}
			}

			return null;
		}

		/**
		 * Проверяет пересекаются ли линии.
		 */
		static public function isLinesIntersects(startLine1:Point, endLine1:Point, startLine2:Point, endLine2:Point):Boolean
		{
			var p1x:Number = startLine1.x;
			var p1y:Number = startLine1.y;
			var p2x:Number = endLine1.x;
			var p2y:Number = endLine1.y;
			var p3x:Number = startLine2.x;
			var p3y:Number = startLine2.y;
			var p4x:Number = endLine2.x;
			var p4y:Number = endLine2.y;

			var p1xSp2x:Number = p1x - p2x;
			var p1ySp2y:Number = p1y - p2y;
			var p1xSp3x:Number = p1x - p3x;
			var p1ySp3y:Number = p1y - p3y;
			var p4xSp3x:Number = p4x - p3x;
			var p4ySp3y:Number = p4y - p3y;

			var d:Number = p1xSp2x * p4ySp3y - p1ySp2y * p4xSp3x;
			var da:Number = p1xSp3x * p4ySp3y - p1ySp3y * p4xSp3x;
			var db:Number = p1xSp2x * p1ySp3y - p1ySp2y * p1xSp3x;

			var ta:Number = da / d;
			var tb:Number = db / d;

			if (ta >= 0)
			{
				if (ta <= 1)
				{
					if (tb >= 0)
					{
						if (tb <= 1) return true;
					}
				}
			}

			return false;
		}

		/**
		 */
		static public function isRectanglesIntersect(topLeft1:Point, bottomRight1:Point, topLeft2:Point, bottomRight2:Point):Boolean
		{
			var ltx1:Number = topLeft1.x;
			var lty1:Number = topLeft1.y;
			var rbx1:Number = bottomRight1.x;
			var rby1:Number = bottomRight1.y;

			var ltx2:Number = topLeft2.x;
			var lty2:Number = topLeft2.y;
			var rbx2:Number = bottomRight2.x;
			var rby2:Number = bottomRight2.y;

			var exp:Boolean = false;

			if (ltx2 >= ltx1)
			{
				if (ltx2 <= rbx1) exp = true;
			}

			if (!exp)
			{
				if (ltx1 >= ltx2)
				{
					if (!(ltx1 <= rbx2)) return false;
				}
				else return false;
			}

			if (lty2 >= lty1)
			{
				if (lty2 <= rby1) return true;
			}

			if (lty1 >= lty2)
			{
				if (lty1 <= rby2) return true;
			}

			return false;
		}
	}
}
