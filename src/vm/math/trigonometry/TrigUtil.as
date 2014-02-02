package vm.math.trigonometry
{
	import flash.geom.Point;

	/**
	 *
	 */
	public class TrigUtil
	{
		/**
		 * Constant for convert radian to degrees
		 * Approximately  57.295779513082320876798154814105
		 */
		static public const RAD_TO_DEG:Number = 180.0 / Math.PI;

		/**
		 * Constant for convert degrees to radians
		 * Approximately 0.017453292519943295769236907684886
		 */
		static public const DEG_TO_RAD:Number = Math.PI / 180.0;

		/**
		 * Constant PI
		 * Approximately 3.1415926535897932384626433832795
		 */
		static public const PI:Number = Math.PI;

		/**
		 * Constant 2*PI
		 * Approximately 6.283185307179586476925286766559
		 */
		static public const PI2:Number = Math.PI * 2;

		/**
		 * Fit angle to range between 0-360 degree.
		 * Angle in radians.
		 */
		static public function fitAngle(p_angle:Number):Number
		{
			var pi2:Number = PI2;

			if (p_angle < 0)
			{
				if (p_angle < -pi2) p_angle %= pi2;
				p_angle += pi2;
			}
			else if (p_angle > pi2) p_angle %= pi2;

			return p_angle;
		}

		/**
		 * Returns angle between two points in degrees.
		 */
		static public function getAnglePointsDeg(p_x1:Number, p_y1:Number, p_x2:Number, p_y2:Number):Number
		{
			return Math.atan2(p_y2 - p_y1, p_x2 - p_x1) * RAD_TO_DEG;
		}

		/**
		 * Returns angle between two points in radians.
		 */
		static public function getAnglePointsRad(p_x1:Number, p_y1:Number, p_x2:Number, p_y2:Number):Number
		{
			return Math.atan2(p_y2 - p_y1, p_x2 - p_x1);
		}

		/**
		 * Returns angle between line and point (value always positive because represents absolute angle).
		 * Angle in radians, if need in degrees, should to multiply result on RAD_TO_DEG const.
		 */
		static public function getAngleLinePoint(p_startLine:Point, p_endLine:Point, p_point:Point):Number
		{
			var x1:Number = p_endLine.x - p_startLine.x;
			var y1:Number = p_endLine.y - p_startLine.y;
			var x2:Number = p_point.x;
			var y2:Number = p_point.y;

			return Math.acos((x1 * x2 + y1 * y2) / Math.sqrt((x1 * x1 + y1 * y1) * (x2 * x2 + y2 * y2)));
		}

		/**
		 * Returns angle between two lines (value always positive because represents absolute angle).
		 * Angle in radians, if need in degrees, should to multiply result on RAD_TO_DEG const.
		 */
		static public function getAngleLines(p_startLine1:Point, p_endLine1:Point, p_startLine2:Point, p_endLine2:Point):Number
		{
			var x1:Number = p_endLine1.x - p_startLine1.x;
			var y1:Number = p_endLine1.y - p_startLine1.y;
			var x2:Number = p_endLine2.x - p_startLine2.x;
			var y2:Number = p_endLine2.y - p_startLine2.y;

			return Math.acos((x1 * x2 + y1 * y2) / Math.sqrt((x1 * x1 + y1 * y1) * (x2 * x2 + y2 * y2)));
		}

		/**
		 * Method looks like 'getAngleLines' except it doesn't calculate arccos, and not returns angle in radians.
		 * This method can be helpful when no need to know angles but need to know, e.g., is one angle greater/smaller then another.
		 * Less value than angle greater.
		 */
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
		static public function getDistance(p_x1:Number, p_y1:Number, p_x2:Number, p_y2:Number):Number
		{
			var xd:Number = p_x1 - p_x2;
			var yd:Number = p_y1 - p_y2;

			return Math.sqrt(xd * xd + yd * yd);
		}

		/**
		 * Returns square distance between points.
		 */
		static public function getDistanceSquare(p_x1:Number, p_y1:Number, p_x2:Number, p_y2:Number):Number
		{
			var xd:Number = p_x1 - p_x2;
			var yd:Number = p_y1 - p_y2;

			return xd * xd + yd * yd;
		}

		/**
		 * Returns direction of vector.
		 */
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
		static public function getIntersectLines(p_p1:Point, p_p2:Point, p_p3:Point, p_p4:Point):Point
		{
			var p1x:Number = p_p1.x;
			var p1y:Number = p_p1.y;
			var p2x:Number = p_p2.x;
			var p2y:Number = p_p2.y;
			var p3x:Number = p_p3.x;
			var p3y:Number = p_p3.y;
			var p4x:Number = p_p4.x;
			var p4y:Number = p_p4.y;

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
		static public function isLinesIntersects(p_startLine_1:Point, p_endLine_1:Point, p_startLine_2:Point, p_endLine_2:Point):Boolean
		{
			var p1x:Number = p_startLine_1.x;
			var p1y:Number = p_startLine_1.y;
			var p2x:Number = p_endLine_1.x;
			var p2y:Number = p_endLine_1.y;
			var p3x:Number = p_startLine_2.x;
			var p3y:Number = p_startLine_2.y;
			var p4x:Number = p_endLine_2.x;
			var p4y:Number = p_endLine_2.y;

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
		 * Determines if rectangles are intersected.
		 */
		static public function isRectanglesIntersect(p_topLeft_1:Point, p_bottomRight_1:Point, p_topLeft_2:Point, p_bottomRight_2:Point):Boolean
		{
			var ltx1:Number = p_topLeft_1.x;
			var lty1:Number = p_topLeft_1.y;
			var rbx1:Number = p_bottomRight_1.x;
			var rby1:Number = p_bottomRight_1.y;

			var ltx2:Number = p_topLeft_2.x;
			var lty2:Number = p_topLeft_2.y;
			var rbx2:Number = p_bottomRight_2.x;
			var rby2:Number = p_bottomRight_2.y;

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
