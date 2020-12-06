package RxGraphicsLibrary.Tools
{
    public class RxDoubleAffair
    {
        public function RxDoubleAffair(
                            minval:Number = 0.0, maxval:Number = 1.0, val:Number = 0.0,
                            tvga:Vector.<Number> = null, tfd:uint = 1)
        {
            if (minval >= maxval)
                throw new Error('maxval must be greater than minval.');

            _minval = minval;
            _maxval = maxval;
            _val = val;
            if (_val < _minval)
                _val = _minval;
            else if (_val > _maxval)
                _val = _maxval;

            if (tvga == null)
                _vga = new <Number>[0.1, 10.0, 0.01, 1.0];
            else
                _vga = tvga;
            _vga.fixed = true;
            _fd = tfd;
        }

        private var _minval:Number;
        private var _maxval:Number;
        private var _val:Number;

        private var _vga:Vector.<Number>;
        private var _fd:uint;



        public function ValueUpDown(tt:String = 'u', ti:uint = 0):void
        {
            if ((tt == 'u') || (tt == 'd'))
            {
                if (_vga == null) return;
                if ((_vga.length > 0) && (ti < _vga.length))
                {
                    var ta:Number = _vga[ti];
                    var tv:Number = _val;

                    if (tt == 'u')
                        tv = _val + ta;
                    else if (tt == 'd')
                        tv = _val - ta;

                    if (tv < _minval)
                        tv = _minval;
                    else if (tv > _maxval)
                        tv = _maxval;

                    _val = tv;
                }
            }
        }



        public function GetMinValue():Number
        {
            return _minval;
        }
        public function SetMinValue(tv:Number):void
        {
			_minval = tv;

            if (_minval > _maxval)
                _minval = _maxval;

            if (_val < _minval)
                _val = _minval;
        }


        public function GetMaxValue():Number
        {
            return _maxval;
        }
        public function SetMaxValue(tv:Number):void
        {
			_maxval = tv;

            if (_maxval < _minval)
                _maxval = _minval;

            if (_val > _maxval)
                _val = _maxval;
        }


        public function GetValue():Number
        {
            return _val;
        }
        public function SetValue(tv:Number):void
        {
            if (tv < _minval)
                tv = _minval;
            else if (tv > _maxval)
                tv = _maxval;

            _val = tv;
        }


        public function GetValueFixed():String
        {
            return _val.toFixed(_fd);
        }


        public function GetRatio():Number
        {
            var tsv:Number = _maxval - _minval;
            if (tsv <= 0) return 0;

            var tr:Number = (_val - _minval) / tsv;
            return tr;
        }

        public function SetRatio(tr:Number):void
        {
            if (tr < 0) tr = 0;
            else if (tr > 1) tr = 1;

            var tsv:Number = _maxval - _minval;
            if (tsv < 0) tsv = 0;
            _val = _minval + (tsv * tr);
        }

    }
}
