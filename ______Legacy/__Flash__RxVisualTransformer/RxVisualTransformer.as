package
{	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	


	public class RxVisualTransformer
	{	
		public function RxVisualTransformer(tdo:DisplayObject)
		{
			_tdo = tdo;
			_mtr = _tdo.transform.matrix;
			pf_ApplyMatrix(false);

		}
		private var _tdo:DisplayObject;
		public function GetTarget():DisplayObject
		{
			return _tdo;
		}
		
		private var _mtr:Matrix;
		public function GetMatrix():Matrix
		{
			return _mtr;
		}
		public function GetMatrixToStr():String
		{
			var tstr:String =
				'(a=' + RxGeom.DoubleRound(_mtr.a) + ', b=' + RxGeom.DoubleRound(_mtr.b) +
				', c=' + RxGeom.DoubleRound(_mtr.c) + ', d=' + RxGeom.DoubleRound(_mtr.d) +
				', tx=' + RxGeom.DoubleRound(_mtr.tx) + ', ty=' + RxGeom.DoubleRound(_mtr.ty) + ')';
			return tstr;
		}
		public function GetInfoStr():String
		{
			var tyrd:Number = RxGeom.GetRadian1(_mtr);			
			var tysx:Number = RxGeom.GetScaleX(_mtr);
			var tysy:Number = RxGeom.GetScaleY(_mtr);			
			var tcx:Number = RxGeom.GetLeftCenter(_rct);
			var tcy:Number = RxGeom.GetTopCenter(_rct);			
			
			var tstr:String =
				'(tyrd=' + tyrd +
				', tysx=' + tysx +
				', tysy=' + tysy +
				', tcx=' + tcx +
				', tcy=' + tcy + ')';
			return tstr;
		}
		
		private var _rct:Rectangle;		
		public function GetRect():Rectangle
		{
			return _rct;
		}
		
        public function GetWidth():Number
        {
            return RxGeom.GetWidth(_rct);
        }
        public function GetHeight():Number
        {
            return RxGeom.GetHeight(_rct);
        }
		
		
		
        public function GetHalfWidth():Number
        {
            return RxGeom.GetHalfWidth(_rct);
        }
        public function GetHalfHeight():Number
        {
            return RxGeom.GetHalfHeight(_rct);
        }
		
		
		
        public function GetLeft():Number
        {
            return RxGeom.GetLeft(_rct);
        }		
        public function GetTop():Number
        {
            return RxGeom.GetTop(_rct);
        }
        public function GetRight():Number
        {
            return RxGeom.GetRight(_rct);
        }
        public function GetBottom():Number
        {
            return RxGeom.GetBottom(_rct);
        }
		
		
		
        public function GetLeftCenter():Number
        {
            return RxGeom.GetLeftCenter(_rct);
        }
        public function GetTopCenter():Number
        {
            return RxGeom.GetTopCenter(_rct);
        }
		
		

        public function GetTX():Number
        {
            return RxGeom.GetTX(_mtr);
        }
        public function GetTY():Number
        {
            return RxGeom.GetTY(_mtr);
        }
		
		
		private function pf_ApplyMatrix(tbx:Boolean = true):void
		{
			if (tbx) _tdo.transform.matrix = _mtr;
			_rct = _tdo.getBounds(_tdo.parent);
			_rct.inflate(40, 40);
		}
		
		private function pf_CheckRadian(trd:Number):Number
		{
			if (trd < 0)
				trd = RxGeom.FullRadianHalf + trd;
			else if (trd >= RxGeom.FullRadianHalf)
				trd = trd - RxGeom.FullRadian;
			return RxGeom.DoubleRound(trd);
		}
		
		
		public function SetRotateCenter(trd:Number):void
		{
			var tyrd:Number = RxGeom.GetRadian1(_mtr);
			var tnrd:Number = pf_CheckRadian(trd);
			//trace(tyrd, tnrd);
			if (tnrd !== tyrd)
			{
				var tcx:Number = RxGeom.GetLeftCenter(_rct);
				var tcy:Number = RxGeom.GetTopCenter(_rct);
				//trace(tcx, tcy);
				_mtr.translate(-tcx, -tcy);
				
				_mtr.rotate(-tyrd);
				_mtr.rotate(tnrd);
				_mtr.translate(tcx, tcy);
				
				pf_ApplyMatrix();
			}
		}
		
		
		public function SetScaleCenter(tsx:Number, tsy:Number):void
		{
			const txx:Number = 0.001;
			
			if (tsx < 0.1) return;
			if (tsy < 0.1) return;
			
			var tysx:Number = RxGeom.GetScaleX(_mtr);
			var tysy:Number = RxGeom.GetScaleY(_mtr);
			//trace(tysx, tysy);
			
			var tnsx:Number = RxGeom.DoubleRound(tsx);
			var tnsy:Number = RxGeom.DoubleRound(tsy);
			//trace(tnsx, tnsy);
			
			if ((tysx !== tnsx) && (tysy !== tnsy))
			{
				var tcx:Number = RxGeom.GetLeftCenter(_rct);
				var tcy:Number = RxGeom.GetTopCenter(_rct);
				//trace(tcx, tcy);
				_mtr.translate(-tcx, -tcy);
				
            	var tbsx:Number = 1 / tysx;
            	var tbsy:Number = 1 / tysy;
				_mtr.scale(tbsx, tbsy);				
				_mtr.scale(tnsx, tnsy);
				_mtr.translate(tcx, tcy);
				
				pf_ApplyMatrix();
			}
		}		
		
		
		
        //~~~~~~~~~~
        public function MoveLeft(tv:Number):void
        {
            var ttx:Number = tv - RxGeom.GetLeft(_rct);
            var tty:Number = 0;
            _mtr.translate(ttx, tty);
			pf_ApplyMatrix();
        }

        public function MoveTop(tv:Number):void
        {
            var ttx:Number = 0;
            var tty:Number = tv - RxGeom.GetTop(_rct);
            _mtr.translate(ttx, tty);
			pf_ApplyMatrix();
        }
		
        //~~~~~~~~~~
        public function MoveLeftCenter(tv:Number):void
        {
            var ttx:Number = tv - RxGeom.GetLeftCenter(_rct);
            var tty:Number = 0;
            _mtr.translate(ttx, tty);
			pf_ApplyMatrix();
        }

        public function MoveTopCenter(tv:Number):void
        {
            var ttx:Number = 0;
            var tty:Number = tv - RxGeom.GetTopCenter(_rct);
            _mtr.translate(ttx, tty);
			pf_ApplyMatrix();
        }
		
        //~~~~~~~~~~
        public function MoveCenter(tx:Number, ty:Number):void
        {
            var ttx:Number = tx - RxGeom.GetLeftCenter(_rct);
            var tty:Number = ty - RxGeom.GetTopCenter(_rct);
            _mtr.translate(ttx, tty);
			pf_ApplyMatrix();
        }
		
		//~~~~~~~~~~
		public function MoveAt(tmx:Number, tmy:Number):void
		{			
			_mtr.translate(-_mtr.tx, -_mtr.ty);
			_mtr.translate(tmx, tmy);
			pf_ApplyMatrix();
		}
		
		
		
		
        public function DrawBorders(tgrp:Graphics):void
        {
            tgrp.clear();
            tgrp.lineStyle(5, 0xff0000, 0.35);
            tgrp.beginFill(0x00ff00, 0.15);
            tgrp.drawRect(_rct.x, _rct.y, _rct.width, _rct.height);
            tgrp.moveTo(_rct.left, _rct.top);
            tgrp.lineTo(_rct.right, _rct.bottom);
            tgrp.moveTo(_rct.left, _rct.bottom);
            tgrp.lineTo(_rct.right, _rct.top);
        }
		
		
	}

}