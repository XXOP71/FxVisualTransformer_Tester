package RxGraphicsLibrary.Controls
{
    import flash.display.DisplayObject;
    import flash.display.Graphics;
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




    public final class RxScrollInput
    {
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        public function RxScrollInput(cont:Sprite, ttp:String,
                            tsz:Number = 400, tssr:Number = 1.0, tpr:Number = 0.0,
                            tcbf:Function = null)
        {
            _cont = cont;
            _cont.tabEnabled = false;


            var spr_rxsb:Sprite = _cont['mvc_rxsb'];
            _rxsb = new RxScrollbar(ttp, spr_rxsb, tsz, tssr, tpr, pf_rxsb__cbf);

			_spr_ipg = _cont['mvcInputGroup'];
            _txb = _spr_ipg['txb'];
            _txb.addEventListener(KeyboardEvent.KEY_DOWN, pf_keyduan);
            _txb.addEventListener(MouseEvent.MOUSE_WHEEL, pf_mswh);


            _rxdbaff = new RxDoubleAffair();
            _txb.text = _rxdbaff.GetValueFixed();

            pf_valupt(false);


            _cbf = tcbf;
        }
        private var _cont:Sprite;
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
		
		private function pf_comupt(te:*, tt:String, tb:Boolean):void
		{			
            var ti:uint = 0;
            if (te.ctrlKey && te.shiftKey)
                ti = 1;
            else if (te.ctrlKey)
                ti = 2;
            else if (te.shiftKey)
                ti = 3;
				
			_rxdbaff.ValueUpDown(tt, ti);
			pf_valupt(tb);			
		}

        private function pf_keyduan(te:KeyboardEvent):void
        {
            if (te.keyCode === Keyboard.UP)
            {
				pf_comupt(te, 'u', true);
            }
            else if (te.keyCode === Keyboard.DOWN)
            {
				pf_comupt(te, 'd', true);
            }
        }

        private function pf_mswh(te:MouseEvent):void
        {
            if (te.delta > 0)
            {
				pf_comupt(te, 'u', true);
            }
            else if (te.delta < 0)
            {
				pf_comupt(te, 'd', true);
            }
        }


        public function CallMouseWheelHandler(te:MouseEvent, tb:Boolean):void
        {
            if (te.delta > 0)
            {
				pf_comupt(te, 'u', tb);
            }
            else if (te.delta < 0)
            {
				pf_comupt(te, 'd', tb);
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
        public function SetCalcValues(tmv:Number, tiv:Number):void
        {
			if (tmv < tiv)
			{
				var tdh:Number = tiv - tmv;
				_rxdbaff.SetMinValue(0.0);
				_rxdbaff.SetMaxValue(tdh);

				var tssr:Number = tmv / tiv;				
				_rxsb.SetScrollSizeRatio(tssr);
				pf_AfterSideUpdate();
			}
			else
			{
				_rxdbaff.SetMinValue(0);
				_rxdbaff.SetMaxValue(0);
				_rxsb.SetScrollSizeRatio(1);				
				pf_AfterSideUpdate();
			}
			
			//trace(tmv / tiv);
        }
		
		
//        public function GetScrollSizeRatio():Number
//        {
//			return _rxsb.GetScrollSizeRatio();
//        }
//		
//        public function SetScrollSizeRatio(tssr:Number):void
//        {
//			_rxsb.SetScrollSizeRatio(tssr);
//        }
		
		
		
		public function ToString():String
		{
			return _rxdbaff.ToString();
		}
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
    }
}

