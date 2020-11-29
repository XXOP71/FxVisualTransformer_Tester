package RxGraphicsLibrary.Tools
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;




	public final class RxGeom
	{
		public static function DoubleRound(tv:Number):Number
		{
			const txx:Number = 1000;
			return Math.round(tv * txx) / txx;
		}

		public static function MatrixInfo(tmtr:Matrix):void
		{
			var tstr:String =
				'a=' + DoubleRound(tmtr.a) + ', c=' + DoubleRound(tmtr.c) + ', tx=' + DoubleRound(tmtr.tx) + ',\n' +
				'b=' + DoubleRound(tmtr.b) + ', d=' + DoubleRound(tmtr.d) + ', ty=' + DoubleRound(tmtr.ty) + ',\n';
			trace(tstr);
		}

		public static function GetDefaultBounds(tdo:DisplayObject):Rectangle
		{
			var tmtr_b:Matrix = tdo.transform.matrix;
			var tmtr:Matrix = tmtr_b.clone();
			tmtr.identity();
			tdo.transform.matrix = tmtr;

			var trct:Rectangle = tdo.getBounds(tdo.parent);
			tdo.transform.matrix = tmtr_b;

			return trct;
		}

		public static function GetBounds(tdrct:Rectangle, tmtr:Matrix, tdx:Number, tdy:Number):Rectangle
		{
			var trct:Rectangle = tdrct.clone();

			trct.x = 0;
			trct.y = 0;

			var tpt0:Point = new Point(trct.left, trct.top);
			var tpt1:Point = new Point(trct.right, trct.top);
			var tpt2:Point = new Point(trct.right, trct.bottom);
			var tpt3:Point = new Point(trct.left, trct.bottom);

			tpt0 = tmtr.transformPoint(tpt0);
			tpt1 = tmtr.transformPoint(tpt1);
			tpt2 = tmtr.transformPoint(tpt2);
			tpt3 = tmtr.transformPoint(tpt3);


			var tex:Number = Math.min(Math.min(tpt0.x, tpt1.x), Math.min(tpt2.x, tpt3.x));
			var tey:Number = Math.min(Math.min(tpt0.y, tpt1.y), Math.min(tpt2.y, tpt3.y));
			var tew:Number = Math.max(Math.max(tpt0.x, tpt1.x), Math.max(tpt2.x, tpt3.x)) - tex;
			var teh:Number = Math.max(Math.max(tpt0.y, tpt1.y), Math.max(tpt2.y, tpt3.y)) - tey;

			trct.x = tex;
			trct.y = tey;
			trct.width = tew;
			trct.height = teh;

			trct.inflate(tdx, tdy);


			return trct;
		}




        //--
        public static const FullAngle:Number = 360;

        //--
        public static const FullAngleHalf:Number = FullAngle / 2;

        //--
        public static const FullAngleQuarter:Number = FullAngle / 4;



        //--
        public static const FullRadian:Number = Math.PI * 2;

        //--
        public static const FullRadianHalf:Number = FullRadian / 2;

        //--
        public static const FullRadianQuarter:Number = FullRadian / 4;



        //--
        public static const ToRadians:Number = Math.PI / 180;

        //--
        public static const ToAngles:Number = 180 / Math.PI;


        //:: Angle To Radian
        public static function GetAngleToRadian(tag:Number):Number
        {
			var tv:Number = tag * ToRadians;
            return DoubleRound(tv);
        }

        //:: Radian To Angle
        public static function GetRadianToAngle(trd:Number):Number
        {
			var tv:Number = trd * ToAngles;
            return DoubleRound(tv);
        }

        public static function GetAngle(tdo:DisplayObject):Number
        {
            return DoubleRound(tdo.rotation);
        }

		public static function CheckRadian(trd:Number):Number
		{
			if (trd < 0)
				trd = FullRadianHalf + trd;
			else if (trd >= FullRadianHalf)
				trd = trd - FullRadian;
			return DoubleRound(trd);
		}





        public static function GetRadian1(tmtr:Matrix):Number
        {
			var tv:Number = Math.atan2(tmtr.b, tmtr.a);
            return DoubleRound(tv);
        }
        public static function GetRadian2(tmtr:Matrix):Number
        {
            var tv:Number = -Math.atan2(tmtr.c, tmtr.d);
			return DoubleRound(tv);
        }

        public static function GetScaleX(tmtr:Matrix):Number
        {
            var tsx:Number = Math.sqrt(Math.pow(tmtr.a, 2) + Math.pow(tmtr.b, 2));
            return DoubleRound(tsx);
        }
        public static function GetScaleY(tmtr:Matrix):Number
        {
            var tsy:Number = Math.sqrt(Math.pow(tmtr.c, 2) + Math.pow(tmtr.d, 2));
            return DoubleRound(tsy);
        }

        public static function GetTX(tmtr:Matrix):Number
        {
            return DoubleRound(tmtr.tx);
        }
        public static function GetTY(tmtr:Matrix):Number
        {
            return DoubleRound(tmtr.ty);
        }




        public static function GetLeft(trct:Rectangle):Number
        {
            return DoubleRound(trct.left);
        }
        public static function GetTop(trct:Rectangle):Number
        {
            return DoubleRound(trct.top);
        }
        public static function GetRight(trct:Rectangle):Number
        {
            return DoubleRound(trct.right);
        }
        public static function GetBottom(trct:Rectangle):Number
        {
            return DoubleRound(trct.bottom);
        }



        public static function GetLeftCenter(trct:Rectangle):Number
        {
            var tcx:Number = trct.left + (trct.width / 2);
            return DoubleRound(tcx);
        }
        public static function GetTopCenter(trct:Rectangle):Number
        {
            var tcy:Number = trct.top + (trct.height / 2);
            return DoubleRound(tcy);
        }



        public static function GetWidth(trct:Rectangle):Number
        {
            return DoubleRound(trct.width);
        }
        public static function GetHeight(trct:Rectangle):Number
        {
            return DoubleRound(trct.height);
        }

        public static function GetHalfWidth(trct:Rectangle):Number
        {
            return DoubleRound(trct.width / 2);
        }
        public static function GetHalfHeight(trct:Rectangle):Number
        {
            return DoubleRound(trct.height / 2);
        }

	}

}