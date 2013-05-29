/**
 * Набор алгоритмов.
 */
package vm.math.algorithms
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.ByteArray;

	import vm.math.structures.Vector2d;
	import vm.math.trigonometry.TrigUtil;

	/**
	 *
	 */
	public class AlgorithmsUtil
	{
		/**
		 * Метод сортирует массив вершин в упорядоченную правосторонню систему.
		 *
		 * @param p_sortedArray - массив точек. Каждый элемент массива это экземпляр класса Vector2d, который содержит координаты вершины.
		 * @return - возвращает отсортированный массив вершин в правостороннюю систему.
		 *
		 */
		static public function sortInRight(p_sortedArray:Vector.<Vector2d>):Vector.<Vector2d>
		{
			var len:int = p_sortedArray.length;
			var tVertex:Vector2d;
			var higher:Vector2d = p_sortedArray[0];
			var indexHigher:int = 0;

			// Находим самую верхнюю вершину
			for (var i:int = 1; i < len; i++)
			{
				tVertex = p_sortedArray[i];

				if (tVertex.y < higher.y)
				{
					higher = tVertex;
					indexHigher = i;
				}
			}

			// Удаляем первую найвысшую вершину
			p_sortedArray.splice(indexHigher, 1);

			//Находим углы от главной ко всем остальным вершинам
			len = p_sortedArray.length;
			var resultVertex:Vector.<Vector2d> = new <Vector2d>[];
			for (i = 0; i < len; i++)
			{
				tVertex = p_sortedArray[i];
				tVertex.value = TrigUtil.getAnglePointsDeg(higher.x, higher.y, tVertex.x, tVertex.y);
				resultVertex[i] = tVertex;
			}

			// Сортируем градусы по возрастанию
			resultVertex.sort(sortOn);

			// В массив первым элементом впихиваем главную вершину.
			resultVertex.unshift(higher);

			return resultVertex;
		}

		/**
		 * Функция сортировки для метода sortInRight.
		 */
		static private function sortOn(vec1:Vector2d, vec2:Vector2d):Number
		{
			if (vec1.value > vec2.value)
			{
				return 1;
			}
			else if (vec1.value < vec2.value)
			{
				return -1;
			}

			return 0;
		}

		/**
		 * Метод находит координаты центра полигона.
		 *
		 * @param verticies - массив вершин полигона.
		 * @return - экземпляр класса Vec2 с координатами центра.
		 */
		static public function findPolygonCenter(verticies:Vector.<Vector2d>):Vector2d
		{
			var center:Vector2d = new Vector2d();  //return center;
			var area:Number = getPolygonArea(verticies);
			var constant:Number = 1 / (6 * area);
			var curVertex:Vector2d;
			var nextVertex:Vector2d;
			var verticesCount:int = verticies.length - 1;
			var cx:Number = 0;
			var cy:Number = 0;
			var secondMultiplier:Number;

			for (var i:int = 0; i < verticesCount; i++)
			{
				curVertex = verticies[i];
				nextVertex = verticies[i + 1];

				secondMultiplier = (curVertex.x * nextVertex.y) - (nextVertex.x * curVertex.y);
				cx += (curVertex.x + nextVertex.x) * secondMultiplier;
				cy += (curVertex.y + nextVertex.y) * secondMultiplier;
			}

			curVertex = verticies[i];
			nextVertex = verticies[0];

			secondMultiplier = (curVertex.x * nextVertex.y) - (nextVertex.x * curVertex.y);
			cx += (curVertex.x + nextVertex.x) * secondMultiplier;
			cy += (curVertex.y + nextVertex.y) * secondMultiplier;

			cx *= constant;
			cy *= constant;

			center.setxy(cx, cy);

			return center;
		}

		/**
		 */
		static public function getPolygonArea(verticies:Vector.<Vector2d>):Number
		{
			var polygonArea:Number;
			var verticesCount:int = verticies.length - 1;
			var sum:Number = 0;
			var curVertex:Vector2d;
			var nextVertex:Vector2d;

			for (var i:int = 0; i < verticesCount; i++)
			{
				curVertex = verticies[i];
				nextVertex = verticies[i + 1];

				sum += ((curVertex.x * nextVertex.y) - (nextVertex.x * curVertex.y));
			}

			curVertex = verticies[i];
			nextVertex = verticies[0];

			sum += ((curVertex.x * nextVertex.y) - (nextVertex.x * curVertex.y));

			polygonArea = sum * 0.5;

			return polygonArea;
		}

		/**
		 *  Метод сортирует массив вершин в упорядоченную правосторонню систему и центрирует их по центру.
		 *  Объдиняет две комманды  sortInRight и  findPolygonCenter, а также делает смещение вершин к центру.
		 */
		static public function sortInRightAndAlignByCenter(sortedArrayPar:Vector.<Vector2d>):Vector.<Vector2d>
		{
			var sortedVertices:Vector.<Vector2d> = sortInRight(sortedArrayPar);
			var centerPoint:Vector2d = findPolygonCenter(sortedVertices);
			var countVertices:int = sortedVertices.length;
			var vertex:Vector2d;

			for (var i:int = 0; i < countVertices; i++)
			{
				vertex = sortedVertices[i];
				vertex.sub(centerPoint);
			}

			return sortedVertices;
		}

		/**
		 * Метод вращает заданный MovieClip вокруг заданной точки НА заданное количество градусов.
		 *
		 * @param    mc - MovieClip
		 * @param   pivotPoint - точка вращения
		 * @param    angle - угол поворота в градусах.
		 */
		static public function rotateAroundPivotPoint(mc:DisplayObject, pivotPoint:Point, angle:Number):void
		{
			// get matrix object from your MovieClip (mc)
			var m:Matrix = mc.transform.matrix;

			// set the point around which you want to rotate your MovieClip (relative to the MovieClip position)
//			var point:Point = new Point(10, 10);

			// get the position of the MovieClip related to its origin and the point around which it needs to be rotated
			pivotPoint = m.transformPoint(pivotPoint);
			// set it
			m.translate(-pivotPoint.x, -pivotPoint.y);

			// rotate it of some°
			m.rotate(angle * (Math.PI / 180));

			// and get back to its "normal" position
			m.translate(pivotPoint.x, pivotPoint.y);

			// finally, to set the MovieClip position, use this
			mc.transform.matrix = m;
		}

		/**
		 * Метод делает клон НЕ визульного объекта.
		 */
		static public function copyObject(value:Object):Object
		{
			var buffer:ByteArray = new ByteArray();
			buffer.writeObject(value);
			buffer.position = 0;
			var result:Object = buffer.readObject();
			return result;
		}
	}
}
