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
        public function RxScrollInput(cont:Sprite, ttp:String,
                            rxsbnm:String ='mvc_rxsb', txbnm:String = 'txb',
                            tsz:Number = 400, tssr:Number = 1.0, tpr:Number = 0.0,
                            minval:Number = 0.0, maxval:Number = 1.0, val:Number = 0.0,
                            tvga:Vector.<Number> = null, tfd:uint = 1,
                            tcbf:Function = null)
        {
            _cont = cont;
            _cont.tabEnabled = false;


            var spr_rxsb:Sprite = _cont[rxsbnm];
            _rxsb = new RxScrollbar(ttp, spr_rxsb, tsz, tssr, tpr, pf_rxsb__cbf);

            _txb = _cont[txbnm];
            _txb.addEventListener(KeyboardEvent.KEY_DOWN, pf_keyduan);
            _txb.addEventListener(MouseEvent.MOUSE_WHEEL, pf_mswh);


            _rxdbaff = new RxDoubleAffair(minval, maxval, val, tvga, tfd);
            _txb.text = _rxdbaff.GetValueFixed();

            pf_val_upt(false);


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
        public function SetScrollSizeRatio(tr:Number):void
        {
            _rxsb.SetScrollSizeRatio(tr);
        }
		
		
        public function GetScrollRatio():Number
        {
            return _rxsb.GetPositionRatio();
        }
        public function SetScrollRatio(tr:Number):void
        {
            return _rxsb.SetPositionRatio(tr);
        }
		

        public function GetValue():Number
        {
            return _rxdbaff.GetValue();
        }
        public function SetValue(tv:Number):void
        {
            _rxdbaff.SetValue(tv);

            var tpr:Number = _rxdbaff.GetRatio();
            _rxsb.SetPositionRatio(tpr);

            _txb.text = _rxdbaff.GetValueFixed();
        }


        private var _cbf:Function;


        public function SetTextBoxPos(tx:Number, ty:Number):void
        {
            try
            {
                var tdo:DisplayObject;

                tdo = _cont.getChildAt(0);
                if (!isNaN(tx)) tdo.x = tx;
                if (!isNaN(ty)) tdo.y = ty;

                tdo = _cont.getChildAt(1);
                if (!isNaN(tx)) tdo.x = 1 + tx;
                if (!isNaN(ty)) tdo.y = ty;
            }
            catch (e:Error) { }
        }


        private function pf_rxsb__cbf():void
        {
            var tpr:Number = _rxsb.GetPositionRatio();
            _rxdbaff.SetRatio(tpr);

            _txb.text = _rxdbaff.GetValueFixed();

            if (_cbf != null)
                _cbf();
        }

        private function pf_val_upt(tb:Boolean):void
        {
            var tpr:Number = _rxdbaff.GetRatio();
            _rxsb.SetPositionRatio(tpr);

            _txb.text = _rxdbaff.GetValueFixed();

            if (tb && (_cbf != null))
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
			pf_val_upt(tb);
		}

        private function pf_keyduan(te:KeyboardEvent):void
        {
            if (te.keyCode == Keyboard.UP)
            {
				pf_comupt(te, 'u', true);
            }
            else if (te.keyCode == Keyboard.DOWN)
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
		
    }
}

