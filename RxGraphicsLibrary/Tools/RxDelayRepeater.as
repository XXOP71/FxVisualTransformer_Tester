package RxGraphicsLibrary.Tools
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import hbx.core.CEventCore;
	import hbx.found.CFrameTimer;
	
	

	public final class RxDelayRepeater
	{
		public static const CF_TYPE_END:String = 'end';
		public static const CF_TYPE_UPDATE:String = 'update';
		public static const CF_TYPE_BEGIN:String = 'begin';
		
		
		public function RxDelayRepeater(tdo:DisplayObject, tbc:int, tdf:int, trc:int, tcf:Function)
		{
			_tdo = tdo;
			_bc = tbc;
			_ftmr = new CFrameTimer(tdf, trc);
			_ftmr.addEventListener(CFrameTimer.ET_END, pf_ftmr_end);
			_ftmr.addEventListener(CFrameTimer.ET_UPDATE, pf_ftmr_update);			
			_cf = tcf;
		}
		private var _tdo:DisplayObject;
		private var _bc:int;
		private var _cc:int = 0;
		private var _rb:Boolean = false;
		private var _cf:Function;
		private var _ftmr:CFrameTimer;
		
		
		
		//::
		private function pf_ftmr_end(te:CEventCore):void
		{
			_cf(CF_TYPE_END);
			stop();
		}
		
		//::
		private function pf_ftmr_update(te:CEventCore):void
		{
			_cf(CF_TYPE_UPDATE);
		}
		
		
		//::
		private function pf_ef(te:Event):void
		{
			_cc++;
			_cf(CF_TYPE_BEGIN);			
			if (_cc > _bc)
			{				
				_tdo.removeEventListener(Event.ENTER_FRAME, pf_ef);
				_ftmr.start();
			}
		}
		
		
		//::
		public function stop():void
		{
			if (_rb)
			{
				_rb = false;
				_tdo.removeEventListener(Event.ENTER_FRAME, pf_ef);
				_ftmr.stop(true);
			}
		}
		
		//::
		public function start():void
		{
			if (_rb) return;
			_cc = 0;
			_rb = true;
			_tdo.addEventListener(Event.ENTER_FRAME, pf_ef);
		}
		
	}
}

