package 
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class GeomMath 
	{
		
		public function GeomMath() 
		{
			
		}
		
		/**
		 * Возвращает результат применения геометрического преобразования, представленного объектом Matrix в заданной точке. (описание спизжено из Matrix.transformPoint
		 */
		public static function transformPoint(matrix:Matrix, x:Number, y:Number, noDelta:Boolean = false, result:Point = null):Point {
			result ||= new Point();
			var dx:Number = noDelta ? 0 : matrix.tx;
			var dy:Number = noDelta ? 0 : matrix.ty;
			result.x = matrix.a * x + matrix.c * y + dx;
			result.y = matrix.d * y + matrix.b * x + dy;
			return result;
		}
		
		public static function transformRectangle(matrix:Matrix, rectangle:Rectangle):Rectangle {
			
			//var a:Number = rectangle.x;
			//var b:Number = rectangle.y;
			//var c:Number = rectangle.right;
			//var d:Number = rectangle.bottom;
			rectangle.x = matrix.a * rectangle.x + matrix.c * rectangle.y + matrix.tx;
			rectangle.y = matrix.d * rectangle.y + matrix.b * rectangle.x + matrix.ty;
			
			
			return rectangle;
		}
		
		/**
		 * То же саоме что matrix.concat() но в итоге не нужен клон матрици от исходной
		 * 
		 * @param	matrixA
		 * @param	matrixB
		 * @param	dest
		 */
		[Inline]
		public static function concatMatrices(matrixA:Matrix, matrixB:Matrix, dest:Matrix):void
		{
			var a:Number = matrixA.a * matrixB.a + matrixA.b * matrixB.c;
			var b:Number = matrixA.a * matrixB.b + matrixA.b * matrixB.d;
			
			var c:Number = matrixA.c * matrixB.a + matrixA.d * matrixB.c;
			var d:Number = matrixA.c * matrixB.b + matrixA.d * matrixB.d;
			
			var tx:Number = matrixA.tx * matrixB.a + matrixA.ty * matrixB.c + matrixB.tx;
			var ty:Number = matrixA.tx * matrixB.b + matrixA.ty * matrixB.d + matrixB.ty;
			
			dest.a = a;
			dest.b =  b;
			dest.c = c;
			dest.d = d;
			dest.tx = tx;
			dest.ty = ty;
		}
		
		public static function rectangleUnion(rect:Rectangle, toUnion:Rectangle):void
		{
			if (rect.width == 0 || rect.height == 0) 
			{
				rect.setTo(toUnion.x, toUnion.y, toUnion.width, toUnion.height);
				return;
			} 
			else if (toUnion.width == 0 || toUnion.height == 0) 
			{
				return;
			}
			
			var x0:Number = rect.x > toUnion.x ? toUnion.x : rect.x;
			var x1:Number = rect.right < toUnion.right ? toUnion.right : rect.right;
			var y0:Number = rect.y > toUnion.y ? toUnion.y : rect.y;
			var y1:Number = rect.bottom < toUnion.bottom ? toUnion.bottom : rect.bottom;
			
			rect.setTo(x0, y0, x1 - x0, y1 - y0);
			
		}
	}

}