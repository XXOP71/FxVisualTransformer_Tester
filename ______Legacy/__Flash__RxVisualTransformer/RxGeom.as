package
{
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	
	
	public final class RxGeom
	{
		public static function DoubleRound(tv:Number):Number
		{
			const txx:Number = 1000;
			return Math.round(tv * txx) / txx;
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