package
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Point;




	// ##
	//
	//
	public final class FxGeometry
	{
        //====================================================================================================
        // ##
        //====================================================================================================
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
            return tag * ToRadians;
        }

        //:: Radian To Angle
        public static function GetRadianToAngle(trd:Number):Number
        {
            return trd * ToAngles;
        }
        //====================================================================================================




        //====================================================================================================
        // ##
        //====================================================================================================
        // (Geomery: Matrix, Rectangle, Point)
        //	a: 1, c: 0, tx: 0,
        //	b: 0, d: 1, ty: 0
        //	u: 0, v: 0, w: 1

        public static function GetBounds(tdo:DisplayObject):Rectangle
        {
            var trct:Rectangle = tdo.getBounds(tdo.parent);
            return trct;
        }

        public static function GetMatrix(tdo:DisplayObject):Matrix
        {
            var tmtr:Matrix = tdo.transform.matrix;
            return tmtr;
        }

        public static function SetMatrix(tdo:DisplayObject, tmtr:Matrix):void
        {
            tdo.transform.matrix = tmtr;
        }
        //====================================================================================================



        //====================================================================================================
        // ##
        //====================================================================================================
        public static function GetRadian1(tmtr:Matrix):Number
        {
            return Math.atan2(tmtr.b, tmtr.a);
        }

        public static function GetRadian2(tmtr:Matrix):Number
        {
            return -Math.atan2(tmtr.c, tmtr.d);
        }

        public static function GetScaleX(tmtr:Matrix):Number
        {
            var tsx:Number = Math.sqrt(Math.pow(tmtr.a, 2) + Math.pow(tmtr.b, 2));
            return tsx;
        }

        public static function GetScaleY(tmtr:Matrix):Number
        {
            var tsy:Number = Math.sqrt(Math.pow(tmtr.c, 2) + Math.pow(tmtr.d, 2));
            return tsy;
        }

        public static function GetWidth(trct:Rectangle):Number
        {
            return trct.width;
        }

        public static function GetHeight(trct:Rectangle):Number
        {
            return trct.height;
        }

        public static function GetWidthHalf(trct:Rectangle):Number
        {
            return trct.width / 2;
        }

        public static function GetHeightHalf(trct:Rectangle):Number
        {
            return trct.height / 2;
        }

        public static function GetLeft(trct:Rectangle):Number
        {
            return trct.left;
        }

        public static function GetTop(trct:Rectangle):Number
        {
            return trct.top;
        }

        public static function GetRight(trct:Rectangle):Number
        {
            return trct.right;
        }

        public static function GetBottom(trct:Rectangle):Number
        {
            return trct.bottom;
        }

        public static function GetLeftCenter(trct:Rectangle):Number
        {
            var tcx:Number = trct.left + (trct.width / 2);
            return tcx;
        }

        public static function GetTopCenter(trct:Rectangle):Number
        {
            var tcy:Number = trct.top + (trct.height / 2);
            return tcy;
        }

        public static function GetCenterPoint(trct:Rectangle):Point
        {
            var tcx:Number = trct.left + (trct.width / 2);
            var tcy:Number = trct.top + (trct.height / 2);
            var tpt:Point = new Point(tcx, tcy);
            return tpt;
        }

        public static function GetRotationToRadian(tdo:DisplayObject):Number
        {
            var tag:Number = tdo.rotation;
            var trd:Number = GetAngleToRadian(tag);
            return trd;
        }
        //====================================================================================================




        //====================================================================================================
        // ##
        //====================================================================================================
        //~~~~~~~~~~
        public static function MoveLeft(trct:Rectangle, tmtr:Matrix, tv:Number):void
        {
            var ttx:Number = tv - GetLeft(trct);
            var tty:Number = 0;
            tmtr.translate(ttx, tty);
        }

        public static function MoveTop(trct:Rectangle, tmtr:Matrix, tv:Number):void
        {
            var ttx:Number = 0;
            var tty:Number = tv - GetTop(trct);
            tmtr.translate(ttx, tty);
        }

        public static function MoveLeftTop(trct:Rectangle, tmtr:Matrix, tx:Number, ty:Number):void
        {
            var ttx:Number = tx - GetLeft(trct);
            var tty:Number = ty - GetTop(trct);
            tmtr.translate(ttx, tty);
        }
        //~~~~~~~~~~


        //~~~~~~~~~~
        public static function MoveRight(trct:Rectangle, tmtr:Matrix, tv:Number):void
        {
            var ttx:Number = tv - GetRight(trct);
            var tty:Number = 0;
            tmtr.translate(ttx, tty);
        }

        public static function MoveBottom(trct:Rectangle, tmtr:Matrix, tv:Number):void
        {
            var ttx:Number = 0;
            var tty:Number = tv - GetBottom(trct);
            tmtr.translate(ttx, tty);
        }

        public static function MoveRightBottom(trct:Rectangle, tmtr:Matrix, tx:Number, ty:Number):void
        {
            var ttx:Number = tx - GetRight(trct);
            var tty:Number = ty - GetBottom(trct);
            tmtr.translate(ttx, tty);
        }
        //~~~~~~~~~~


        //~~~~~~~~~~
        public static function MoveLeftCenter(trct:Rectangle, tmtr:Matrix, tv:Number):void
        {
            var ttx:Number = tv - GetLeftCenter(trct);
            var tty:Number = 0;
            tmtr.translate(ttx, tty);
        }

        public static function MoveTopCenter(trct:Rectangle, tmtr:Matrix, tv:Number):void
        {
            var ttx:Number = 0;
            var tty:Number = tv - GetTopCenter(trct);
            tmtr.translate(ttx, tty);
        }

        public static function MoveCenter(trct:Rectangle, tmtr:Matrix, tx:Number, ty:Number):void
        {
            var ttx:Number = tx - GetLeftCenter(trct);
            var tty:Number = ty - GetTopCenter(trct);
            tmtr.translate(ttx, tty);
        }
        //~~~~~~~~~~





        //~~~~~~~~~~
        public static function RotateAt(tmtr:Matrix, tcx:Number, tcy:Number, trd:Number):void
        {
            tmtr.translate(-tcx, -tcy);
            tmtr.rotate(trd);
            tmtr.translate(tcx, tcy);
        }

        public static function RotateCenter(trct:Rectangle, tmtr:Matrix, trd:Number):void
        {
            var tcx:Number = GetLeftCenter(trct);
            var tcy:Number = GetTopCenter(trct);
            tmtr.translate(-tcx, -tcy);
            tmtr.rotate(trd);
            tmtr.translate(tcx, tcy);
        }

        public static function SetRotateAt(tmtr:Matrix, tcx:Number, tcy:Number, trd:Number):void
        {
            tmtr.translate(-tcx, -tcy);
            var tyt:Number = GetRadian1(tmtr);
            tmtr.rotate(-tyt);
            tmtr.rotate(trd);
            tmtr.translate(tcx, tcy);
        }

        public static function SetRotateCenter(trct:Rectangle, tmtr:Matrix, trd:Number):void
        {
            var tcx:Number = GetLeftCenter(trct);
            var tcy:Number = GetTopCenter(trct);
            tmtr.translate(-tcx, -tcy);
            var tyr:Number = GetRadian1(tmtr);
            tmtr.rotate(-tyr);
            tmtr.rotate(trd);
            tmtr.translate(tcx, tcy);
        }
        //~~~~~~~~~~





        //~~~~~~~~~~
        public static function ScaleAt(tmtr:Matrix, tcx:Number, tcy:Number, tsx:Number, tsy:Number):void
        {
            if (tsx < 0.3) tsx = 0.3;
            if (tsy < 0.3) tsy = 0.3;

            tmtr.translate(-tcx, -tcy);
            tmtr.scale(tsx, tsy);
            tmtr.translate(tcx, tcy);
        }

        public static function ScaleCenter(trct:Rectangle, tmtr:Matrix, tsx:Number, tsy:Number):void
        {
            if (tsx < 0.3) tsx = 0.3;
            if (tsy < 0.3) tsy = 0.3;

            var tcx:Number = GetLeftCenter(trct);
            var tcy:Number = GetTopCenter(trct);
            tmtr.translate(-tcx, -tcy);
            tmtr.scale(tsx, tsy);
            tmtr.translate(tcx, tcy);
        }

        public static function SetScaleAt(tmtr:Matrix, tcx:Number, tcy:Number, tsx:Number, tsy:Number):void
        {
            if (tsx < 0.3) tsx = 0.3;
            if (tsy < 0.3) tsy = 0.3;

            tmtr.translate(-tcx, -tcy);
            var tysx:Number = 1 / GetScaleX(tmtr);
            var tysy:Number = 1 / GetScaleY(tmtr);
            tmtr.scale(tysx, tysy);
            tmtr.scale(tsx, tsy);
            tmtr.translate(tcx, tcy);
        }

        public static function SetScaleCenter(trct:Rectangle, tmtr:Matrix, tsx:Number, tsy:Number):void
        {
            if (tsx < 0.3) tsx = 0.3;
            if (tsy < 0.3) tsy = 0.3;

            var tcx:Number = GetLeftCenter(trct);
            var tcy:Number = GetTopCenter(trct);
            tmtr.translate(-tcx, -tcy);

            var tysx:Number = GetScaleX(tmtr);
            var tysy:Number = GetScaleY(tmtr);
            tysx = (tysx == 0) ? 1 : tysx;
            tysy = (tysy == 0) ? 1 : tysy;

            var tmsx:Number = 1 / tysx;
            var tmsy:Number = 1 / tysy;
            tmtr.scale(tmsx, tmsy);
            tmtr.scale(tsx, tsy);
            tmtr.translate(tcx, tcy);
        }
        //~~~~~~~~~~





        //~~~~~~~~~~
        //:: tcpt(CenterPoint)를 기준으로 ttpt(TargetPoint)를 trd(라디안)만큼 회전하는 Point를 반환
        public static function GetRcpt(tcpt:Point, ttpt:Point, trd:Number):Point
        {
            var tmtr:Matrix = new Matrix();
            tmtr.translate(-tcpt.x, -tcpt.y);
            tmtr.rotate(trd);
            tmtr.translate(tcpt.x, tcpt.y);
            //trace('tmtr:', tmtr);

            var tnpt:Point = tmtr.transformPoint(ttpt);
            //var tnpt:Point = tmtr.deltaTransformPoint(ttpt);
            //trace(tnpt);
            return tnpt;
        }
        //~~~~~~~~~~
        //====================================================================================================


	}

}
