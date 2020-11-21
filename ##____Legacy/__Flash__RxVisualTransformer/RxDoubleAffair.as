package
{
    public class RxDoubleAffair
    {
        public function RxDoubleAffair(
                            minval:Number = 0.0, maxval:Number = 1.0, val:Number = 0.0,
                            txa:Number = 0.1, txb:Number = 10.0, txc:Number = 0.01, txd:Number = 1.0,
                            tfd:uint = 1)
        {
            if (minval >= maxval)
                throw new Error('maxval must be greater than minval.');

            _minval = minval;
            _maxval = maxval;

            if (val < _minval)
                val = _minval;
            else if (val > _maxval)
                val = _maxval;
            _val = val;
            //trace(_minval, _maxval, _val);

            _xa = txa;
            _xb = txb;
            _xc = txc;
            _xd = txd;
            //trace(_xa, _xb, _xc, _xd);

            _fd = tfd;
            //trace(_fd);
        }

        private var _minval:Number;
        private var _maxval:Number;
        private var _val:Number;

        private var _xa:Number;
        private var _xb:Number;
        private var _xc:Number;
        private var _xd:Number;

        private var _fd:uint;



        public function ValueUpDown(tt:String = 'up', tn:uint = 1):void
        {
            if (((tt == 'up') || (tt == 'down')) &&
                ((tn >= 1) && (tn <= 4)))
            {
                var ta:Number;
                if (tn == 1)
                    ta = _xa;
                else if (tn == 2)
                    ta = _xb;
                else if (tn == 3)
                    ta = _xc;
                else if (tn == 4)
                    ta = _xd;

                var tv:Number;
                if (tt == 'up')
                    tv = _val + ta;
                else if (tt == 'down')
                    tv = _val - ta;

                if (tv < _minval)
                    tv = _minval;
                else if (tv > _maxval)
                    tv = _maxval;

                _val = tv;
            }
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

    }
}
