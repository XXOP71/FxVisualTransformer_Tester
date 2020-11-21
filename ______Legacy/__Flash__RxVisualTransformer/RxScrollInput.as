package
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




    public final class RxScrollInput
    {
        public function RxScrollInput(cont:Sprite, ttp:String,
                            rxsbnm:String ='mvc_rxsb', txbnm:String = 'txb',
                            tsz:Number = 400, tssr:Number = 1.0, tpr:Number = 0.0,
                            minval:Number = 0.0, maxval:Number = 1.0, val:Number = 0.0,
                            txa:Number = 0.1, txb:Number = 10.0, txc:Number = 0.01, txd:Number = 1.0,
                            tfd:uint = 1, tcbf:Function = null)
        {
            _cont = cont;
            _cont.tabEnabled = false;
			

            var spr_rxsb:Sprite = _cont[rxsbnm];
            _rxsb = new RxScrollbar(ttp, spr_rxsb, tsz, tssr, tpr, pf_rxsb__cbf);

            _txb = _cont[txbnm];
            _txb.addEventListener(KeyboardEvent.KEY_DOWN, pf_keyduan);
            _txb.addEventListener(MouseEvent.MOUSE_WHEEL, pf_mswh);


            _rxdbaff = new RxDoubleAffair(minval, maxval, val, txa, txb, txc, txd, tfd);
            _txb.text = _rxdbaff.GetValueFixed();

            pf_val_upt();


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

        public function GetVal():Number
        {
            return _rxdbaff.GetValue();
        }
        public function SetVal(tv:Number):void
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

        private function pf_val_upt():void
        {
            var tpr:Number = _rxdbaff.GetRatio();
            _rxsb.SetPositionRatio(tpr);

            _txb.text = _rxdbaff.GetValueFixed();

            if (_cbf != null)
                _cbf();
        }

        private function pf_keyduan(te:KeyboardEvent):void
        {
            var tn:uint = 1;
            if (te.ctrlKey && te.shiftKey)
                tn = 2;
            else if (te.ctrlKey)
                tn = 3;
            else if (te.shiftKey)
                tn = 4;

            if (te.keyCode == Keyboard.UP)
            {
                _rxdbaff.ValueUpDown('up', tn);
                pf_val_upt();
            }
            else if (te.keyCode == Keyboard.DOWN)
            {
                _rxdbaff.ValueUpDown('down', tn);
                pf_val_upt();
            }
        }

        private function pf_mswh(te:MouseEvent):void
        {
            var tn:uint = 1;
            if (te.ctrlKey && te.shiftKey)
                tn = 2;
            else if (te.ctrlKey)
                tn = 3;
            else if (te.shiftKey)
                tn = 4;

            if (te.delta > 0)
            {
                _rxdbaff.ValueUpDown('up', tn);
                pf_val_upt();
            }
            else if (te.delta < 0)
            {
                _rxdbaff.ValueUpDown('down', tn);
                pf_val_upt();
            }
        }
		
		public function CallMouseWheelHandler(te:MouseEvent):void
		{
			pf_mswh(te);
		}
    }
}

