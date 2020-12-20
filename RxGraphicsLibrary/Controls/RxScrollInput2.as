package RxGraphicsLibrary.Controls
{
	import flash.display.DisplayObjectContainer;
    import flash.display.DisplayObject;
    import flash.display.Graphics;
	import flash.display.SimpleButton;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import RxGraphicsLibrary.Tools.RxDoubleAffair;    
    import RxGraphicsLibrary.Tools.RxDelayRepeater;
    




    public final class RxScrollInput2
    {
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        public function RxScrollInput2(cont:Sprite, ttp:String, tcbf:Function)
        {
            _cont = cont;
            _cont.tabEnabled = false;			
			_cont.addEventListener(MouseEvent.MOUSE_WHEEL, pf_mswh);
			
			_stage = _cont.stage;
			_stage.addEventListener(KeyboardEvent.KEY_UP, pf_keyup);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, pf_keydown);
			

            var spr_rxsb:Sprite = _cont['mvc_rxsb'];
            _rxsb = new RxScrollbar(ttp, spr_rxsb, spr_rxsb.width, 1.0, 0.0, pf_rxsb__cbf);
			
			_spr_ipg = _cont['mvc_ipgb'];			
            _txb = _spr_ipg['txb'];
			
            _rxdbaff = new RxDoubleAffair();
            _txb.text = _rxdbaff.GetValueFixed();

            pf_valupt(false);
			
			
            _cbf = tcbf;
			
			
			
			
			_btnl = _spr_ipg['btnl'];
			_btnl.addEventListener(MouseEvent.MOUSE_DOWN, pf_btnl_md);
			_btnl.addEventListener(MouseEvent.MOUSE_UP, pf_btnl_mu);
			
			_btnr = _spr_ipg['btnr'];
			_btnr.addEventListener(MouseEvent.MOUSE_DOWN, pf_btnr_md);
			_btnr.addEventListener(MouseEvent.MOUSE_UP, pf_btnr_mu);
			
			
			_drt = new RxDelayRepeater(_cont, 5, 3, 0, pf_drt_cf);
			
        }
        private var _cont:Sprite;
		private var _stage:Stage;
        public function GetCont():Sprite
        {
            return _cont;
        }


        private var _rxsb:RxScrollbar;
        public function GetScrollbar():RxScrollbar
        {
            return _rxsb;
        }


		private var _spr_ipg:Sprite;
        private var _txb:TextField;
        public function GetTextBox():TextField
        {
            return _txb;
        }
		


        private var _rxdbaff:RxDoubleAffair;
        public function GetDoubleAffair():RxDoubleAffair
        {
            return _rxdbaff;
        }


        private var _cbf:Function;
        public function GetCallback():Function
        {
            return _cbf;
        }
		
		
		public function Clear():void
		{
			if (_cont === null) return;
			
			_spr_ipg = null;
			
			_txb.text = '';
			_txb = null;
			
			_cbf = null;

			_rxsb = null;			
			_rxdbaff = null;
			
			
			
			_btnl.addEventListener(MouseEvent.MOUSE_DOWN, pf_btnl_md);
			_btnl.addEventListener(MouseEvent.MOUSE_UP, pf_btnl_mu);
			_btnl = null;			
			
			_btnr.addEventListener(MouseEvent.MOUSE_DOWN, pf_btnr_md);
			_btnr.addEventListener(MouseEvent.MOUSE_UP, pf_btnr_mu);
			_btnr = null;
			
			
			_drt.stop();
			_drt = null;
			
			
			_stage.removeEventListener(KeyboardEvent.KEY_UP, pf_keyup);
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, pf_keydown);
			_stage = null;
			
			_cont.removeEventListener(MouseEvent.MOUSE_WHEEL, pf_mswh);
			_cont = null;
		}
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		
		
		
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        public function GetContX():Number
        {
            return _cont.x;
        }
        public function SetContX(tv:Number):void
        {
            _cont.x = tv;
        }
		
		
        public function GetContY():Number
        {
            return _cont.y;
        }
        public function SetContY(tv:Number):void
        {
            _cont.y = tv;
        }
		
		
        public function SetTbX(tv:Number):void
        {
            _spr_ipg.x = tv;
        }
        public function SetTbY(tv:Number):void
        {
            _spr_ipg.y = tv;
        }
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		
		
		
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        private function pf_rxsb__cbf():void
        {
            var tpr:Number = _rxsb.GetPositionRatio();
            _rxdbaff.SetRatio(tpr);
            _txb.text = _rxdbaff.GetValueFixed();

            if (_cbf !== null)
                _cbf();
        }

        private function pf_valupt(tb:Boolean):void
        {
            var tpr:Number = _rxdbaff.GetRatio();
            _rxsb.SetPositionRatio(tpr);
            _txb.text = _rxdbaff.GetValueFixed();

            if (tb && (_cbf !== null))
                _cbf();
        }		
		
		private function pf_IsOver():Boolean
		{
			var tdoc:DisplayObjectContainer = _cont.parent;
			var trct:Rectangle = _cont.getBounds(tdoc);
			var tmx:Number = tdoc.mouseX;
			var tmy:Number = tdoc.mouseY;
			return trct.contains(tmx, tmy);
		}
		
		private function pf_comupt(tb:Boolean):void
		{				
			_rxdbaff.ValueUpDown(_rut, _ri);
			pf_valupt(tb);
		}
		
		
		private function pf_kopset(te:KeyboardEvent, teb:Boolean):void
		{
			if (teb)
			{
				if (te.keyCode === Keyboard.LEFT)
					_rut = 'd';
				else if (te.keyCode === Keyboard.RIGHT)
					_rut = 'u';
			}
			
			_ri = 0;
			if (te.ctrlKey && te.shiftKey)
				_ri = 1;
			else if (te.ctrlKey)
				_ri = 2;
			else if (te.shiftKey)
				_ri = 3;
		}
		
		private function pf_keyup(te:KeyboardEvent):void		
		{
			_ri = 0;
		}
        private function pf_keydown(te:KeyboardEvent):void
        {
			if (pf_IsOver())
			{
				if ((te.keyCode === Keyboard.LEFT) ||
					(te.keyCode === Keyboard.RIGHT))
				{
					pf_kopset(te, true);
					pf_comupt(true);
				}
				else
				{
					pf_kopset(te, false);
				}
			}
        }
		
		
		
		private function pf_kkupt_me(te:MouseEvent):void
		{
            if (te.delta < 0)
				_rut = 'd';
            else if (te.delta > 0)
				_rut = 'u';
				
			_ri = 0;
			if (te.ctrlKey && te.shiftKey)
				_ri = 1;
			else if (te.ctrlKey)
				_ri = 2;
			else if (te.shiftKey)
				_ri = 3;
		}

        private function pf_mswh(te:MouseEvent):void
        {
			pf_kkupt_me(te);
			pf_comupt(true);
        }

        public function CallMouseWheelHandler(te:MouseEvent, tb:Boolean):void
        {
			pf_kkupt_me(te);
			pf_comupt(tb);
        }
		
		
		
		
		
		private var _rut:String;
		private var _ri:uint;
		
		
		private var _btnl:SimpleButton;				
		private function pf_btnl_mu(te:MouseEvent):void
		{
			_drt.stop();
		}
		private function pf_btnl_md(te:MouseEvent):void
		{
			_rut = 'd';
			_drt.start();
			pf_drt_cf(RxDelayRepeater.CF_TYPE_UPDATE);
		}
		
		private var _btnr:SimpleButton;
		private function pf_btnr_mu(te:MouseEvent):void
		{
			_drt.stop();
		}
		private function pf_btnr_md(te:MouseEvent):void
		{
			_rut = 'u';
			_drt.start();
			pf_drt_cf(RxDelayRepeater.CF_TYPE_UPDATE);
		}


		private var _drt:RxDelayRepeater;
		private function pf_drt_cf(ttp:String):void
		{
			if (ttp === RxDelayRepeater.CF_TYPE_BEGIN) { }
			else
			{
				_rxdbaff.ValueUpDown(_rut, _ri);
				pf_valupt(true);
			}
		}
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		
		
		
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        public function GetScrollbarSize():Number
        {
            return _rxsb.GetSize();
        }
        public function SetScrollbarSize(tv:Number):void
        {
            _rxsb.SetSize(tv);
        }
		
		
        public function GetScrollSizeRatio():Number
        {
			return _rxsb.GetScrollSizeRatio();
        }
		
        public function SetScrollSizeRatio(tssr:Number):void
        {
			_rxsb.SetScrollSizeRatio(tssr);
        }
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		
		
		
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
        public function GetValueGapArr():Vector.<Number>
        {
			return _rxdbaff.GetValueGapArr();
        }
        public function SetValueGapArr(tvga:Vector.<Number>):void
        {
			_rxdbaff.SetValueGapArr(tvga);
        }
		
		
        public function GetFixedNum():uint
        {
			return _rxdbaff.GetFixedNum();
        }
        public function SetFixedNum(tfd:uint):void
        {
			_rxdbaff.SetFixedNum(tfd);
        }
		
		
		
		
		//````(중요)
		private function pf_AfterSideUpdate():void
		{
            var tpr:Number = _rxdbaff.GetRatio();
            _rxsb.SetPositionRatio(tpr);
            _txb.text = _rxdbaff.GetValueFixed();
		}
		
		
		
        public function GetMinValue():Number
        {
            return _rxdbaff.GetMinValue();
        }
        public function SetMinValue(tv:Number):void
        {
			_rxdbaff.SetMinValue(tv);
			pf_AfterSideUpdate();
        }
		
		
        public function GetMaxValue():Number
        {
            return _rxdbaff.GetMaxValue();
        }
        public function SetMaxValue(tv:Number):void
        {
			_rxdbaff.SetMaxValue(tv);
			pf_AfterSideUpdate();
        }
		
		
        public function GetValue():Number
        {
            return _rxdbaff.GetValue();
        }
        public function SetValue(tv:Number):void
        {
            _rxdbaff.SetValue(tv);
			pf_AfterSideUpdate();
        }
		
		
        public function GetRatio():Number
        {
            return _rxdbaff.GetRatio();
        }
        public function SetRatio(tr:Number):void
        {
			_rxdbaff.SetRatio(tr);
			pf_AfterSideUpdate();
        }
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		
		
		
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
        public function SetValues(min:Number, max:Number, val:Number, tssr:Number):void
        {
			if (min < max)
			{
				_rxdbaff.SetMinValue(min);
				_rxdbaff.SetMaxValue(max);
				_rxdbaff.SetValue(val);
				_rxsb.SetScrollSizeRatio(tssr);
				pf_AfterSideUpdate();				
			}
			else			
			{
				_rxdbaff.SetMinValue(0);
				_rxdbaff.SetMaxValue(0);
				_rxdbaff.SetValue(0);
				_rxsb.SetScrollSizeRatio(1);				
				pf_AfterSideUpdate();
			}
        }

		
		public function ToString():String
		{
			return _rxdbaff.ToString();
		}
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
    }
}

