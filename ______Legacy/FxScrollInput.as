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




    public final class FxScrollInput
    {
        public function FxScrollInput(cont:Sprite, ttp:String,
                            fxsbnm:String ='mvc_fxsb', txbnm:String = 'txb',
                            tsz:Number = 400, tssr:Number = 1.0, tpr:Number = 0.0,
                            minval:Number = 0.0, maxval:Number = 1.0, val:Number = 0.0,
                            txa:Number = 0.1, txb:Number = 10.0, txc:Number = 0.01, txd:Number = 1.0,
                            tfd:uint = 1, tcbf:Function = null)
        {
            _cont = cont;
            _cont.tabEnabled = false;
            //trace(_cont.numChildren, _cont.getChildAt(0), _cont.getChildAt(1), _cont.getChildAt(2));


            var spr_fxsb:Sprite = _cont[fxsbnm];
            _fxsb = new FxScrollbar(ttp, spr_fxsb, tsz, tssr, tpr, pf_fxsb_upt);


            _txb = _cont[txbnm];
            _txb.addEventListener(KeyboardEvent.KEY_DOWN, pf_keyduan);
            _txb.addEventListener(MouseEvent.MOUSE_WHEEL, pf_mswh);


            _fxdbaff = new FxDoubleAffair(minval, maxval, val, txa, txb, txc, txd, tfd);
            _txb.text = _fxdbaff.GetValueFixed();

            pf_val_upt();


            _cbf = tcbf;
        }
        private var _cont:Sprite;
        public function GetCont():Sprite
        {
            return _cont;
        }

        private var _fxsb:FxScrollbar;
        public function GetScrollbar():FxScrollbar
        {
            return _fxsb;
        }

        private var _txb:TextField;
        public function GetTextBox():TextField
        {
            return _txb;
        }

        private var _fxdbaff:FxDoubleAffair;
        public function GetDoubleAffair():FxDoubleAffair
        {
            return _fxdbaff;
        }

        public function GetVal():Number
        {
            return _fxdbaff.GetValue();
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




        private function pf_val_upt():void
        {
            var tpr:Number = _fxdbaff.GetRatio();
            _fxsb.SetPositionRatio(tpr);

            _txb.text = _fxdbaff.GetValueFixed();

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
                _fxdbaff.ValueUpDown('up', tn);
                pf_val_upt();
            }
            else if (te.keyCode == Keyboard.DOWN)
            {
                _fxdbaff.ValueUpDown('down', tn);
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
                _fxdbaff.ValueUpDown('up', tn);
                pf_val_upt();
            }
            else if (te.delta < 0)
            {
                _fxdbaff.ValueUpDown('down', tn);
                pf_val_upt();
            }
        }
		
		public function CallMouseWheelHandler(te:MouseEvent):void
		{
			pf_mswh(te);
		}
		

        private function pf_fxsb_upt(te:Event):void
        {
            var tpr:Number = _fxsb.GetPositionRatio();
            _fxdbaff.SetRatio(tpr);

            _txb.text = _fxdbaff.GetValueFixed();

            if (_cbf != null)
                _cbf();
        }
    }
}

