package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.ui.Keyboard;
	
	

	
	public class RxVisualTransformer_Tester extends Sprite
	{
		public function RxVisualTransformer_Tester()
		{
			_owrt = this;
			_owrt.mouseEnabled = false;
			_owrt.tabChildren = false;
			_stg = _owrt.stage;			
			_stg.scaleMode = StageScaleMode.NO_SCALE;
			_stg.align = StageAlign.TOP_LEFT;
			_stg.addEventListener(Event.RESIZE, pf_stage__resize);
			_rctBounds = new Rectangle(0, 0, 0, 0);
			
			_sprArea = _owrt['mvcArea'];
			_sprArea.mouseChildren = false;
			//_sprArea.mouseEnabled = false;
			_sprArea.buttonMode = true;

			_sprMask = _owrt['mvcMask'];
			_sprMask.mouseChildren = false;
			_sprMask.mouseEnabled = false;

			_sprImg = _owrt['mvcImage'];
			_sprImg.mouseChildren = false;
			_sprImg.mouseEnabled = false;
			
			_sprGrpCont = _owrt['mvcGrpCont'];
			_grp = _sprGrpCont.graphics;
			_sprGrpCont.mouseChildren = false;
			_sprGrpCont.mouseEnabled = false;

			_sprBorder = _owrt['mvcBorder'];
			_sprBorder.mouseChildren = false;
			_sprBorder.mouseEnabled = false;
			
			
			_rxvt = new RxVisualTransformer(_sprImg);
			_rxvt.DrawBorders(_grp);
			
			
			
			_rxsipScale = new RxScrollInput(
								_owrt['mvc_rxsipScale'], RxScrollbar.TYPE_HORIZONTAL, 'mvc_rxsb', 'txb',
								300, 0.1, 0.0,
								0.3, 5.0, 1.0,
								0.01, 10.0, 0.001, 0.1,
								3, pf_rxsbScale__Update);

			_rxsipRotate = new RxScrollInput(
								_owrt['mvc_rxsipRotate'], RxScrollbar.TYPE_HORIZONTAL, 'mvc_rxsb', 'txb',
								300, 0.1, 0.0,
								0.0, RxGeom.FullAngle, 0.0,
								1.0, 100.0, 0.1, 10.0,//(Normal),(Ctrl+Shift),(Ctrl),(Shift)
								3, pf_rxsipRotate__Update);


			_rxsipVert = new RxScrollInput(
								_owrt['mvc_rxsipVert'], RxScrollbar.TYPE_VERTICAL, 'mvc_rxsb', 'txb',
								600, 1.0, 0.0,
								0.0, 1.0, 0.5,
								0.01, 1.0, 0.001, 0.1,
								2, pf_rxsiVert__cbf);
		
			_rxsipHori = new RxScrollInput(
								_owrt['mvc_rxsipHori'], RxScrollbar.TYPE_HORIZONTAL, 'mvc_rxsb', 'txb',
								700, 1.0, 0.0,
								0.0, 1.0, 0.5,
								0.01, 1.0, 0.001, 0.1,
								2, pf_rxsipHori__cbf);
								
			
			
			
			
			pf_stage__resize(null);
			
			
			
			

			_sprArea.addEventListener(MouseEvent.MOUSE_WHEEL, pf_sprArea__mouseWheel);
			_sprArea.addEventListener(MouseEvent.MOUSE_DOWN, pf_sprArea__mouseDown);
		}
		private var _owrt:RxVisualTransformer_Tester;
		private var _stg:Stage;
		private var _rctBounds:Rectangle;
		
		private var _sprArea:Sprite;
		private var _rctArea:Rectangle;
		private var _sprMask:Sprite;
		private var _sprImg:Sprite;
		
		private var _sprGrpCont:Sprite;
		private var _grp:Graphics;
		
		private var _sprBorder:Sprite;
		
		
		private var _rxvt:RxVisualTransformer;
		
		private var _rxsipScale:RxScrollInput;
		private var _rxsipRotate:RxScrollInput;
		
		private var _rxsipVert:RxScrollInput;
		private var _rxsipHori:RxScrollInput;
		
		
		
		private function pf_stage__resize(te:Event):void
		{
			var tsw:Number = _stg.stageWidth;
			var tsh:Number = _stg.stageHeight;
		
			_rctBounds.width = tsw - 40;
			_rctBounds.height = tsh - 140;

			_sprBorder.width = _rctBounds.width;
			_sprBorder.height = _rctBounds.height;

			var ttw:Number = _rctBounds.width - 20;
			var tth:Number = _rctBounds.height - 20;
			var ttx:Number = 10;
			var tty:Number = 10;
			_sprArea.width = ttw;
			_sprArea.height = tth;
			_sprArea.x = ttx;
			_sprArea.y = tty;
			_rctArea = _sprArea.getBounds(_owrt);

			_sprMask.width = ttw;
			_sprMask.height = tth;
			_sprMask.x = ttx;
			_sprMask.y = tty;


			_rxsipVert.GetCont().x = _rctBounds.right;
			_rxsipVert.GetScrollbar().SetSize(_rctBounds.height);
			_rxsipVert.SetTextBoxPos(NaN, tsh - 30);
		
			_rxsipHori.GetCont().y = _rctBounds.height;
			_rxsipHori.GetScrollbar().SetSize(_rctBounds.width);
			_rxsipHori.SetTextBoxPos(tsw - 142, NaN);



			tty = _rctBounds.height + 80;
			_rxsipScale.GetCont().y = tty;
		
			tty = _rctBounds.height + 110;
			_rxsipRotate.GetCont().y = tty;
		
		
			pf_ImageHeightUpdate();
			pf_ImageWidthUpdate();
		}
		
		private function pf_ImageHeightUpdate():void
		{
			var rctArea:Rectangle = _rctArea;
			var rctImg:Rectangle = _rxvt.GetRect();
		
			var tmh:Number = rctArea.height;
			var tih:Number = rctImg.height;
			var tssrh:Number = tmh / tih;
			
			_rxsipVert.GetScrollbar().SetScrollSizeRatio(tssrh);
			if (tssrh < 1)
			{
				var tssh:Number = tih - tmh;
				var tprh:Number = _rxsipVert.GetScrollbar().GetPositionRatio();
				var tiy:Number = rctArea.top - (tssh * tprh);
		
				_rxvt.MoveTop(tiy);
				_rxvt.DrawBorders(_grp);
			}
			else
			{
				var tmy:Number = RxGeom.GetTopCenter(rctArea);
				_rxvt.MoveTopCenter(tmy);
				_rxvt.DrawBorders(_grp);
			}
		}
		
		private function pf_ImageWidthUpdate():void
		{
			var rctArea:Rectangle = _rctArea;
			var rctImg:Rectangle = _rxvt.GetRect();
			
			var tmw:Number = rctArea.width;
			var tiw:Number = rctImg.width;
			var tssrw:Number = tmw / tiw;
			
			_rxsipHori.GetScrollbar().SetScrollSizeRatio(tssrw);
			if (tssrw < 1)
			{
				var tssw:Number = tiw - tmw;
				var tprw:Number = _rxsipHori.GetScrollbar().GetPositionRatio();
				var tix:Number = rctArea.left - (tssw * tprw);
		
				_rxvt.MoveLeft(tix);
				_rxvt.DrawBorders(_grp);
			}
			else
			{
				var tmx:Number = RxGeom.GetLeftCenter(rctArea);
				_rxvt.MoveLeftCenter(tmx);
				_rxvt.DrawBorders(_grp);
			}
		}
		
		
		private function pf_rxsbScale__Update():void
		{
			var tsa:Number = _rxsipScale.GetVal();
			_rxvt.SetScaleCenter(tsa, tsa);
			_rxvt.DrawBorders(_grp);
			
			pf_ImageHeightUpdate();
			pf_ImageWidthUpdate();
		}
		
		private function pf_rxsipRotate__Update():void
		{
			var tag:Number = _rxsipRotate.GetVal();
			var trd:Number = RxGeom.GetAngleToRadian(tag);
			_rxvt.SetRotateCenter(trd);
			_rxvt.DrawBorders(_grp);
			
			pf_ImageHeightUpdate();
			pf_ImageWidthUpdate();
		}
		
		
		private function pf_rxsiVert__cbf():void
		{
			var rctArea:Rectangle = _rctArea;
			var rctImg:Rectangle = _rxvt.GetRect();
		
			var tssrh:Number = _rxsipVert.GetScrollbar().GetScrollSizeRatio();
			if (tssrh < 1)
			{
				var tmh:Number = rctArea.height;
				var tih:Number = rctImg.height;
				var tssh:Number = tih - tmh;
				var tprh:Number = _rxsipVert.GetScrollbar().GetPositionRatio();
				var tiy:Number = rctArea.top - (tssh * tprh);
				
				_rxvt.MoveTop(tiy);
				_rxvt.DrawBorders(_grp);
			}
		}
		
		private function pf_rxsipHori__cbf():void
		{
			var rctArea:Rectangle = _rctArea;
			var rctImg:Rectangle = _rxvt.GetRect();
		
			var tssrw:Number = _rxsipHori.GetScrollbar().GetScrollSizeRatio();
			if (tssrw < 1)
			{
				var tmw:Number = rctArea.width;
				var tiw:Number = rctImg.width;
				var tssw:Number = tiw - tmw;
				var tprw:Number = _rxsipHori.GetScrollbar().GetPositionRatio();
				var tix:Number = rctArea.left - (tssw * tprw);
				
				_rxvt.MoveLeft(tix);
				_rxvt.DrawBorders(_grp);
			}
		}
		
		
		private function pf_scrollSetFx__Vert():void
		{
			var tmh:Number = RxGeom.GetHeight(_rctArea);
			var tih:Number = _rxvt.GetHeight();
			var tssh:Number = tih - tmh;
			if (tssh > 0)
			{
				var tiy:Number = RxGeom.GetTop(_rctArea) - _rxvt.GetTop();
				var tpr:Number = tiy / tssh;
				//trace(tiy, tssh, tiy / tssh);
				//_rxsipVert.GetScrollbar().SetPositionRatio(tpr);
				_rxsipVert.SetVal(tpr);
			}
		}		
		
		private function pf_scrollSetFx__Hori():void
		{
			var tmw:Number = RxGeom.GetWidth(_rctArea);
			var tiw:Number = _rxvt.GetWidth();
			var tssw:Number = tiw - tmw;
			if (tssw > 0)
			{
				var tix:Number = RxGeom.GetLeft(_rctArea) - _rxvt.GetLeft();
				var tpr:Number = tix / tssw;
				//trace(tix, tssw, tix / tssw);
				//_rxsipHori.GetScrollbar().SetPositionRatio(tpr);
				_rxsipHori.SetVal(tpr);
			}
		}
		
		
		private function pf_sprArea__mouseWheel(te:MouseEvent):void
		{
			if (te.altKey)
			{
				_rxsipRotate.CallMouseWheelHandler(te);
			}
			else
			{
				_rxsipScale.CallMouseWheelHandler(te);
			}
		}
		
		
		
		private function pf_sprArea__mouseUp(te:MouseEvent):void
		{
			if (_mdpt == null) return;
			
			_stg.removeEventListener(MouseEvent.MOUSE_UP, pf_sprArea__mouseUp);
			_stg.removeEventListener(MouseEvent.MOUSE_MOVE, pf_sprArea__mouseMove);
			_mdpt = null;
		}
		
		private function pf_sprArea__mouseMove(te:MouseEvent):void
		{
			if (_mdpt == null) return;
			
			var tx_gl:Number = RxGeom.GetLeft(_rctArea) + (_rxvt.GetLeftCenter() - _rxvt.GetLeft());
			var tx_gr:Number = RxGeom.GetRight(_rctArea) - (_rxvt.GetRight() - _rxvt.GetLeftCenter());
			var tx_gt:Number = RxGeom.GetTop(_rctArea) + (_rxvt.GetTopCenter() - _rxvt.GetTop());
			var tx_gb:Number = RxGeom.GetBottom(_rctArea) - (_rxvt.GetBottom() - _rxvt.GetTopCenter());
			//trace(tx_gl, tx_gr, tx_gt, tx_gb);
			
			var tx_d:Number = RxGeom.GetWidth(_rctArea) - _rxvt.GetWidth();
			var ty_d:Number = RxGeom.GetHeight(_rctArea) - _rxvt.GetHeight();
			//trace(tx_d, ty_d);
			
			var tmx:Number = _owrt.mouseX - _mdpt.x;
			var tmy:Number = _owrt.mouseY - _mdpt.y;
			//trace(tmx, tmy);
			
			
			if (tx_d < 0)
			{
				if (tmx > tx_gl)
					tmx = tx_gl;
				else if (tmx < tx_gr)
					tmx = tx_gr;
			}
			else
			{
				tmx = RxGeom.GetRight(_rctArea) - RxGeom.GetHalfWidth(_rctArea);
			}
			
				
			if (ty_d < 0)
			{
				if (tmy > tx_gt)
					tmy = tx_gt;
				else if (tmy < tx_gb)
					tmy = tx_gb;
			}
			else
			{
				tmy = RxGeom.GetBottom(_rctArea) - RxGeom.GetHalfHeight(_rctArea);
			}
			
			
			//trace(tmx, tmy);
			//_rxvt.MoveAt(tmx, tmy);
			_rxvt.MoveCenter(tmx, tmy);
			_rxvt.DrawBorders(_grp);
			
			
			pf_scrollSetFx__Vert();
			pf_scrollSetFx__Hori();
			
			
			if (te !== null)
				te.updateAfterEvent();
		}
		
		private var _mdpt:Point;
		private function pf_sprArea__mouseDown(te:MouseEvent):void
		{			
			var ttx:Number = _owrt.mouseX - _rxvt.GetLeftCenter();
			var tty:Number = _owrt.mouseY - _rxvt.GetTopCenter();
			_mdpt = new Point(ttx, tty);
			
			_stg.addEventListener(MouseEvent.MOUSE_UP, pf_sprArea__mouseUp);
			_stg.addEventListener(MouseEvent.MOUSE_MOVE, pf_sprArea__mouseMove);
			pf_sprArea__mouseMove(null);			
		}
		
	}
}