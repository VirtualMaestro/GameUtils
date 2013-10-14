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
		 * Returns angle between two points in degrees.
		 */
		[Inline]
		static public function getAnglePointsDeg(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var x:Number = x2 - x1;
			var y:Number = y2 - y1;

			return Math.atan2(y, x) * RAD_TO_DEG;
		}

		/**
		 * Returns angle between two points in radians.
		 */
		[Inline]
		static public function getAnglePointsRad(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var x:Number = x2 - x1;
			var y:Number = y2 - y1;

			return Math.atan2(y, x);
		}

		/**
		 * Returns angle between two lines.
		 * Angle in radians, if need in degrees, should to multiply result on RAD_TO_DEG const.
		 */
		[Inline]
		static public function getAngleLines(startLine1:Point, endLine1:Point, startLine2:Point, endLine2:Point):Number
		{
			var x1:Number = endLine1.x - startLine1.x;
			var y1:Number = endLine1.y - startLine1.y;
			var x2:Number = endLine2.x - startLine2.x;
			var y2:Number = endLine2.y - startLine2.y;

			return Math.acos((x1 * x2 + y1 * y2) / Math.sqrt((x1 * x1 + y1 * y1) * (x2 * x2 + y2 * y2)));
		}

		/**
		 * Method looks like 'getAngleLines' except it doesn't calculate arccos, and not returns angle in radians.
		 * This method can be helpful when no need to know angles but need to know, e.g., is one angle greater/smaller then another.
		 * Less value than angle greater.
		 */
		[Inline]
		static public function getCosALines(p_startLine1X:Number, p_startLine1Y:Number, p_endLine1X:Number, p_endLine1Y:Number, p_startLine2X:Number,
		                                    p_startLine2Y:Number, p_endLine2X:Number, p_endLine2Y:Number):Number
		{
			var x1:Number = p_endLine1X - p_startLine1X;
			var y1:Number = p_endLine1Y - p_startLine1Y;
			var x2:Number = p_endLine2X - p_startLine2X;
			var y2:Number = p_endLine2Y - p_startLine2Y;

			return (x1 * x2 + y1 * y2) / Math.sqrt((x1 * x1 + y1 * y1) * (x2 * x2 + y2 * y2));
		}

		/**
		 * Returns distance between points.
		 */
		[Inline]
		static public function getDistance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var xd:Number = x1 - x2;
			var yd:Number = y1 - y2;

			return Math.sqrt(xd * xd + yd * yd);
		}

		/**
		 * Returns square distance between points.
		 */
		[Inline]
		static public function getDistanceSquare(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var xd:Number = x1 - x2;
			var yd:Number = y1 - y2;

			return xd * xd + yd * yd;
		}

		/**
		 * Returns direction of vector.
		 */
		[Inline]
		static public function getDirection(p_startLineX:Number, p_startLineY:Number, p_endLineX:Number, p_endLineY:Number):Point
		{
			var x:Number = p_endLineX - p_startLineX;
			var y:Number = p_endLineY - p_startLineY;
			var len:Number = Math.sqrt(x * x + y * y);

			return new Point(x / len, y / len);
		}

		/**
		 * Return perpendicular vector to given.
		 * If normalize = true, vector is normalized.
		 */
		[Inline]
		static public function getPerpendicular(p_startVectorX:Number, p_startVectorY:Number, p_endVectorX:Number, p_endVectorY:Number,
		                                        p_isNormalize:Boolean = false):Point
		{
			var perpX:Number = -(p_endVectorY - p_startVectorY);
			var perpY:Number = p_endVectorX - p_startVectorX;

			if (p_isNormalize && (perpX + perpY) != 0)
			{
				var len:Number = Math.sqrt(perpX * perpX + perpY * perpY);
				perpX /= len;
				perpY /= len;
			}

			return new Point(perpX, perpY);
		}

		/**
		 * Returns point of intersection of two lines.
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
		 * Check whether lines are intersected.
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
