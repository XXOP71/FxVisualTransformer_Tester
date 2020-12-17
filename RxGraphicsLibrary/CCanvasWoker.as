package RxGraphicsLibrary
{
	import flash.display.Sprite;
	import hbx.common.CSpriteWrapper;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Shape;
	import flash.display.Graphics;
	import hbx.utils.MNumberUtil;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.MovieClip;
	


	public final class CCanvasWoker extends CSpriteWrapper
	{
		public static function InitOnce(spr:Sprite):void
		{
			_mcw = new CCanvasWoker(spr);
		}
		private static var _mcw:CCanvasWoker;
		
		
		
		public function CCanvasWoker(spr:Sprite)
		{
			super(spr);
			
			
			_sprt.mouseChildren = false;
			_sprt.buttonMode = true;
			_sprt.cacheAsBitmap = true;
			
			
			
			_sprt.addEventListener(MouseEvent.MOUSE_DOWN, pf_MouseDown);
			
			
			
			var mvcProto:MovieClip = MovieClip(_sprt['mvcCellItemProto']);
			_sprt.removeChild(mvcProto);
			_prtc = mvcProto.constructor;
			trace('~~~~>>> ', _prtc);
		}
		
		private var _prtc:Class;
		private var _pta:Vector.<Point> = new Vector.<Point>();
		
		
		private var _fnum:uint = 0;
		private function pf_DrawPoint(tpt:Point):void
		{
			var mvc_item:MovieClip = new _prtc();
			//trace(mvc_item);
			_sprt.addChild(mvc_item);
			mvc_item.mouseChildren = false;
			mvc_item.mouseEnabled = false;
			mvc_item.alpha = 0.75;
			mvc_item.x = tpt.x,
			mvc_item.y = tpt.y;
			
			var ttf:TextField = mvc_item['txb1'];
			ttf.autoSize = TextFieldAutoSize.CENTER;
			ttf.text = '{ ' + tpt.toString() + '}';
			
			_fnum++;
			if (_fnum > mvc_item.totalFrames)
				_fnum = 1;
			trace(_fnum);
			mvc_item.gotoAndStop(_fnum);
			
			
			
			/*
			var tfnum:int = MNumberUtil.randRange(1, mvc_item.totalFrames);
			mvc_item.gotoAndStop(tfnum);
			*/
			
			/*
			var tsh:Shape = new Shape();
			_sprt.addChild(tsh);
			var tg:Graphics = tsh.graphics;
			
			var tcl:uint = MNumberUtil.randRange(0, 0xffffff);
			tg.beginFill(tcl);
			tg.drawCircle(0, 0, 30);
			tg.endFill();
			
			tsh.x = tpt.x,
			tsh.y = tpt.y;
			*/
			
			
			/*
            var label:TextField = new TextField();
            label.autoSize = TextFieldAutoSize.LEFT;
            label.background = true;
            label.border = true;

            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0xFF0000;
            format.size = 10;
            format.underline = true;

            label.defaultTextFormat = format;
            _sprt.addChild(label);
			
			label.text = '{ ' + tpt.toString() + '}';
			
			label.x = tpt.x - (label.width / 2),
			label.y = tpt.y - (label.height / 2);
			
			label.cacheAsBitmap = true;
			*/
		}
		
		private function pf_MouseMove(te:MouseEvent):void
		{
			var tpt:Point = new Point(_sprt.mouseX, _sprt.mouseY);
			_pta.push(tpt);
			pf_DrawPoint(tpt);
		}
		
		private function pf_MouseUp(te:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, pf_MouseUp);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, pf_MouseUp);
		}
		
		private function pf_MouseDown(te:MouseEvent):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, pf_MouseUp);
			_stage.addEventListener(MouseEvent.MOUSE_UP, pf_MouseUp);			
			
			pf_MouseMove(null);
		}		
	}	
}
