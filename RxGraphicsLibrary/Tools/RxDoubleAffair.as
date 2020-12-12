package RxGraphicsLibrary.Tools
{
    public class RxDoubleAffair
    {
        public function RxDoubleAffair()
        {
			_vga = new <Number>[0.1, 10.0, 0.01, 1.0];
            _vga.fixed = true;
            _fd = 1;			
			
            Reset();
        }
        private var _vga:Vector.<Number>;
        private var _fd:uint;
		

        public function GetValueGapArr():Vector.<Number>
        {
			return _vga;
        }
        public function SetValueGapArr(tvga:Vector.<Number>):void
        {
			_vga = tvga;
			_vga.fixed = true;
        }


        public function GetFixedNum():uint
        {
			return _fd;
        }
        public function SetFixedNum(tfd:uint):void
        {
			_fd = tfd;
        }
		
		
		
		

        private var _min:Number;
        private var _max:Number;
        private var _val:Number;
		private var _vr:Number;//ValueRatio

		

        public function ValueUpDown(tt:String = 'u', ti:uint = 0):void
        {
            if ((tt === 'u') || (tt === 'd'))
            {
                if (_vga === null) return;
                if ((_vga.length > 0) && (ti < _vga.length))
                {
                    var ta:Number = _vga[ti];
                    var tv:Number = _val;

                    if (tt === 'u')
                        tv = _val + ta;
                    else if (tt === 'd')
                        tv = _val - ta;
						
					pf_AssignValue(tv);
                }
            }
        }



        public function GetMinValue():Number
        {
            return _min;
        }
        public function SetMinValue(tv:Number):void
        {
			_min = tv;

            if (_max < _min)
                _max = _min;

            pf_CheckValue(true);
        }



        public function GetMaxValue():Number
        {
            return _max;
        }
        public function SetMaxValue(tv:Number):void
        {
			_max = tv;

            if (_min > _max)
                _min = _max;

            pf_CheckValue(true);
        }


		
		private function pf_CheckValue(tb:Boolean):void
		{
            if (_val < _min)
                _val = _min;
            else if (_val > _max)
				_val = _max;
				
			if (tb)
			{
				var tsv:Number = _max - _min;
				if (tsv <= 0)
					_vr = 0;
				else
					_vr = (_val - _min) / tsv;
			}
		}
		private function pf_AssignValue(tv:Number, tb:Boolean = true):void
		{
			_val = tv;
            pf_CheckValue(tb);
		}
        public function GetValue():Number
        {
            return _val;
        }
        public function SetValue(tv:Number):void
        {
			pf_AssignValue(tv);
        }



        public function GetValueFixed():String
        {
            return _val.toFixed(_fd);
        }
		
		
		
		private function pf_AssignRatio(tr:Number):void
		{
			_vr = tr;
			
            if (_vr < 0)
				_vr = 0;
            else if (_vr > 1)
				_vr = 1;

            var tsv:Number = _max - _min;
			if (tsv <= 0)
				pf_AssignValue(_min, false);
			else
				pf_AssignValue(_min + (tsv * _vr), false);
		}		
        public function GetRatio():Number
        {
			return _vr;
        }
        public function SetRatio(tr:Number):void
        {			
			pf_AssignRatio(tr);
        }



        public function Reset():void
        {
            _min = 0.0;
            _max = 1.0;
            _val = _min;
			_vr = 0;
        }
		
		
		
		
		
		public function ToString():String
		{
			return 'MinValue: ' + GetMinValue() + '\n' +
				'MaxValue: ' + GetMaxValue() + '\n' +
				'Value: ' + GetValue() + '\n' +
				'ValueGapArr: ' + GetValueGapArr() + '\n' +
				'FixedNum: ' + GetFixedNum() + '\n' +
				'ValueFixed: ' + GetValueFixed() + '\n' +
				'Ratio: ' + GetRatio();
		}

    }
}
