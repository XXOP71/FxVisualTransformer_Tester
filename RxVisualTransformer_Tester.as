import flash.display.Graphics;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.ui.Keyboard;
import RxGraphicsLibrary.Controls.RxScrollbar;
import RxGraphicsLibrary.Controls.RxScrollInput;
import RxGraphicsLibrary.Controls.RxVisualTransformer;
import RxGraphicsLibrary.Tools.RxGeom;











//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//:: 최종적으로 변형행렬 적용
function pf_ApplyMatrix():void
{
	_rxvt.ApplyMatrix();
	_rxvt.DrawBorders(_grp);
			
			
	var ttf:TextField;
	
	var tmtr:Matrix = _rxvt.GetMatrix();			
	ttf = _sprAllInfo['txbma'];
	ttf.text = RxGeom.DoubleRound(tmtr.a).toString();
	ttf = _sprAllInfo['txbmb'];
	ttf.text = RxGeom.DoubleRound(tmtr.b).toString();
	ttf = _sprAllInfo['txbmc'];
	ttf.text = RxGeom.DoubleRound(tmtr.c).toString();
	ttf = _sprAllInfo['txbmd'];
	ttf.text = RxGeom.DoubleRound(tmtr.d).toString();
	ttf = _sprAllInfo['txbmx'];
	ttf.text = RxGeom.DoubleRound(tmtr.tx).toString();
	ttf = _sprAllInfo['txbmy'];
	ttf.text = RxGeom.DoubleRound(tmtr.ty).toString();
	
	var trct:Rectangle = _rxvt.GetRect();
	ttf = _sprAllInfo['txbra'];
	ttf.text = RxGeom.DoubleRound(trct.left).toString();
	ttf = _sprAllInfo['txbrb'];
	ttf.text = RxGeom.DoubleRound(trct.top).toString();
	ttf = _sprAllInfo['txbrc'];
	ttf.text = RxGeom.DoubleRound(trct.width).toString();
	ttf = _sprAllInfo['txbrd'];
	ttf.text = RxGeom.DoubleRound(trct.height).toString();
	
	
	ttf = _sprAllInfo['txbfa'];
	ttf.text = '::' + _rxvt.GetCount().toString();
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//::
function pf_ImageSizeUpdate__Vert(tb:Boolean = true):void
{
	var rctImg:Rectangle = _rxvt.GetRect();	
	_rxsipVert.SetCalcValues(_rctArea.height, rctImg.height);
	
	if (tb)
	{
		var tsd:Number = rctImg.height - _rctArea.height;
		if (tsd > 0)
		{
			var tiy:Number = _rctArea.top - _rxsipVert.GetValue();	
			_rxvt.MoveTop(tiy);
		}
		else
		{
			var tmy:Number = RxGeom.GetTopCenter(_rctArea);
			_rxvt.MoveTopCenter(tmy);
		}
	}
}

//::
function pf_ImageSizeUpdate__Hori(tb:Boolean = true):void
{
	var rctImg:Rectangle = _rxvt.GetRect();	
	_rxsipHori.SetCalcValues(_rctArea.width, rctImg.width);
	
	if (tb)
	{
		var tsd:Number = rctImg.width - _rctArea.width;
		if (tsd > 0)
		{
			var tix:Number = _rctArea.left - _rxsipHori.GetValue();	
			_rxvt.MoveLeft(tix);
		}
		else
		{
			var tmx:Number = RxGeom.GetLeftCenter(_rctArea);
			_rxvt.MoveLeftCenter(tmx);
		}
	}
}

//::
function pf_stage__resize(te:Event):void
{
	var tsw:Number = _stg.stageWidth;
	var tsh:Number = _stg.stageHeight;


	if (tsw < 680) tsw = 680;
	if (tsh < 480) tsh = 480;
	trace(tsw, tsh);	
		
	
	
	_rctArea.width = tsw - 300,
	_rctArea.height = tsh - 100;
	//trace('_rctArea:', _rctArea);
	
	
	var ttw:Number = _rctArea.width;
	var tth:Number = _rctArea.height;
	var ttx:Number = _rctArea.left;
	var tty:Number = _rctArea.top;		
	
	
	_sprArea.width = ttw;
	_sprArea.height = tth;
	
	_sprMask.width = ttw;
	_sprMask.height = tth;
	
	_sprBorder.width = ttw + 20;
	_sprBorder.height = tth + 20;
	
	_sprCrossHead.x = RxGeom.GetLeftCenter(_rctArea);
	_sprCrossHead.y = RxGeom.GetTopCenter(_rctArea);	
	
	
	
	ttx = tsw - 290;
	_rxsipVert.SetContX(ttx);
	tth = tsh - 100;
	_rxsipVert.SetScrollbarSize(tth);
	_rxsipVert.SetTbY(tth - 74);
	
	tty = tsh - 90;		
	_rxsipHori.SetContY(tty);
	ttw = tsw - 300;
	_rxsipHori.SetScrollbarSize(ttw);
	_rxsipHori.SetTbX(ttw + 30);

	
	
	
	tty = tsh - 54;
	_rxsipScale.SetContY(tty);
	
	tty = tsh - 30;
	_rxsipRotate.SetContY(tty);	
	
	
	_sprAllInfo.x = tsw - 260;
	_sprAllInfo.y = tsh - 106;
	
	
	
	pf_ImageSizeUpdate__Vert();
	pf_ImageSizeUpdate__Hori();
	pf_ApplyMatrix();
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//::
function pf_rxsipVert__cbf():void
{
	var rctImg:Rectangle = _rxvt.GetRect();
	
	var tsd:Number = rctImg.height - _rctArea.height;
	if (tsd > 0)
	{
		var tiy:Number = _rctArea.top - _rxsipVert.GetValue();	
		_rxvt.MoveTop(tiy);
		pf_ApplyMatrix();
	}
}

//::
function pf_rxsipHori__cbf():void
{
	var rctImg:Rectangle = _rxvt.GetRect();
	
	var tsd:Number = rctImg.width - _rctArea.width;
	if (tsd > 0)
	{
		var tix:Number = _rctArea.left - _rxsipHori.GetValue();	
		_rxvt.MoveLeft(tix);
		pf_ApplyMatrix();
	}
}



//::
function pf_ScrollSetFx__Vert():void
{
	var tmh:Number = RxGeom.GetHeight(_rctArea);
	var tih:Number = _rxvt.GetHeight();
	var tssh:Number = tih - tmh;
	if (tssh > 0)
	{
		var tiy:Number = RxGeom.GetTop(_rctArea) - _rxvt.GetTop();
		var tpr:Number = tiy / tssh;
		_rxsipVert.SetRatio(tpr);
	}
}

//::
function pf_ScrollSetFx__Hori():void
{
	var tmw:Number = RxGeom.GetWidth(_rctArea);
	var tiw:Number = _rxvt.GetWidth();
	var tssw:Number = tiw - tmw;
	if (tssw > 0)
	{
		var tix:Number = RxGeom.GetLeft(_rctArea) - _rxvt.GetLeft();
		var tpr:Number = tix / tssw;
		_rxsipHori.SetRatio(tpr);
	}
}

//::
function pf_BeforeMove(tmx:Number, tmy:Number):void
{
	var tx_d:Number = RxGeom.GetWidth(_rctArea) - _rxvt.GetWidth();
	if (tx_d < 0)
	{
		var tx_gl:Number = RxGeom.GetLeft(_rctArea) + _rxvt.GetHalfWidth();
		var tx_gr:Number = RxGeom.GetRight(_rctArea) - _rxvt.GetHalfWidth();
		
		if (tmx > tx_gl)
			tmx = tx_gl;
		else if (tmx < tx_gr)
			tmx = tx_gr;
	}
	else
	{
		tmx = RxGeom.GetRight(_rctArea) -
			RxGeom.GetHalfWidth(_rctArea);
	}

	var ty_d:Number = RxGeom.GetHeight(_rctArea) - _rxvt.GetHeight();
	if (ty_d < 0)
	{
		var tx_gt:Number = RxGeom.GetTop(_rctArea) + _rxvt.GetHalfHeight();
		var tx_gb:Number = RxGeom.GetBottom(_rctArea) - _rxvt.GetHalfHeight();
		
		if (tmy > tx_gt)
			tmy = tx_gt;
		else if (tmy < tx_gb)
			tmy = tx_gb;
	}
	else
	{
		tmy = RxGeom.GetBottom(_rctArea) -
			RxGeom.GetHalfHeight(_rctArea);
	}

	
	_rxvt.MoveCenter(tmx, tmy);	
}

//::
function pf_rxsipScale__cbf():void
{
	var tcx:Number = RxGeom.GetLeftCenter(_rctArea);
	var tcy:Number = RxGeom.GetTopCenter(_rctArea);
	
	var tsa:Number = _rxsipScale.GetValue();
	if (_rxvt.SetScaleAt(tcx, tcy, tsa, tsa))
	{
		pf_BeforeMove(_rxvt.GetLeftCenter(), _rxvt.GetTopCenter());		
		pf_ImageSizeUpdate__Vert(false);
		pf_ImageSizeUpdate__Hori(false);
		pf_ApplyMatrix();

		pf_ScrollSetFx__Vert();
		pf_ScrollSetFx__Hori();
	}
}

//::
function pf_rxsipRotate__cbf():void
{
	var tcx:Number = RxGeom.GetLeftCenter(_rctArea);
	var tcy:Number = RxGeom.GetTopCenter(_rctArea);
	
	var tag:Number = _rxsipRotate.GetValue();
	var trd:Number = RxGeom.GetAngleToRadian(tag);
	if (_rxvt.SetRotateAt(tcx, tcy, trd))
	{
		pf_BeforeMove(_rxvt.GetLeftCenter(), _rxvt.GetTopCenter());		
		pf_ImageSizeUpdate__Vert(false);
		pf_ImageSizeUpdate__Hori(false);
		pf_ApplyMatrix();

		pf_ScrollSetFx__Vert();
		pf_ScrollSetFx__Hori();
	}
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//::
function pf_sprArea__mouseWheel(te:MouseEvent):void
{
	var tcx:Number = RxGeom.GetLeftCenter(_rctArea);
	var tcy:Number = RxGeom.GetTopCenter(_rctArea);			
	if (te.altKey)
	{
		_rxsipRotate.CallMouseWheelHandler(te, false);
		
		var tag:Number = _rxsipRotate.GetValue();
		var trd:Number = RxGeom.GetAngleToRadian(tag);
		if (_rxvt.SetRotateAt(tcx, tcy, trd))
		{
			pf_BeforeMove(_rxvt.GetLeftCenter(), _rxvt.GetTopCenter());		
			pf_ImageSizeUpdate__Vert(false);
			pf_ImageSizeUpdate__Hori(false);
			pf_ApplyMatrix();
	
			pf_ScrollSetFx__Vert();
			pf_ScrollSetFx__Hori();
		}
	}
	else
	{				
		_rxsipScale.CallMouseWheelHandler(te, false);
		
		var tsa:Number = _rxsipScale.GetValue();
		if (_rxvt.SetScaleAt(tcx, tcy, tsa, tsa))
		{
			pf_BeforeMove(_rxvt.GetLeftCenter(), _rxvt.GetTopCenter());		
			pf_ImageSizeUpdate__Vert(false);
			pf_ImageSizeUpdate__Hori(false);
			pf_ApplyMatrix();
	
			pf_ScrollSetFx__Vert();
			pf_ScrollSetFx__Hori();
		}
	}
}

function pf_sprArea__mouseUp(te:MouseEvent):void
{
	if (_mdpt === null) return;

	_stg.removeEventListener(MouseEvent.MOUSE_UP, pf_sprArea__mouseUp);
	_stg.removeEventListener(MouseEvent.MOUSE_MOVE, pf_sprArea__mouseMove);
	_mdpt = null;
}

function pf_sprArea__mouseMove(te:MouseEvent):void
{
	if (_mdpt === null) return;
	
	pf_BeforeMove(_owrt.mouseX - _mdpt.x, _owrt.mouseY - _mdpt.y);
	pf_ApplyMatrix();

	pf_ScrollSetFx__Vert();
	pf_ScrollSetFx__Hori();


	if (te !== null)
		te.updateAfterEvent();
}

var _mdpt:Point;
function pf_sprArea__mouseDown(te:MouseEvent):void
{
	var ttx:Number = _owrt.mouseX - _rxvt.GetLeftCenter();
	var tty:Number = _owrt.mouseY - _rxvt.GetTopCenter();
	_mdpt = new Point(ttx, tty);

	_stg.addEventListener(MouseEvent.MOUSE_UP, pf_sprArea__mouseUp);
	_stg.addEventListener(MouseEvent.MOUSE_MOVE, pf_sprArea__mouseMove);

	pf_sprArea__mouseMove(null);
}

//::
function pf_InitOnce():void
{
	_stg = _owrt.stage;
	_stg.align = StageAlign.TOP_LEFT;
	_stg.scaleMode = StageScaleMode.NO_SCALE;
	
	
	
	_rctArea = new Rectangle(10, 10, 500, 500);	

	
	_sprArea = _owrt['mvcArea'];
	_sprArea.mouseChildren = false;
	_sprArea.buttonMode = true;
	
	_sprMask = _owrt['mvcMask'];
	_sprMask.mouseChildren = false;
	_sprMask.mouseEnabled = false;
	_sprMask.visible = false;	
	
	_sprImg = _owrt['mvcImage'];
	_sprImg.mouseChildren = false;
	_sprImg.mouseEnabled = false;	
	
	_sprGrpCont = _owrt['mvcGrpCont'];
	_sprGrpCont.mouseChildren = false;
	_sprGrpCont.mouseEnabled = false;
	_grp = _sprGrpCont.graphics;	
	
	_sprBorder = _owrt['mvcBorder'];
	_sprBorder.mouseChildren = false;
	_sprBorder.mouseEnabled = false;
	
	_sprCrossHead = _owrt['mvcCrossHead'];
	_sprCrossHead.mouseChildren = false;
	_sprCrossHead.mouseEnabled = false;
	
	
	
	_rxvt = new RxVisualTransformer(_sprImg);
	_rxvt.DrawBorders(_grp);
	
	
	
	
	_rxsipVert = new RxScrollInput(
		_owrt['mvc_rxsipVert'], RxScrollbar.TYPE_VERTICAL,
			500, 1.0, 0.0, pf_rxsipVert__cbf);
	_rxsipVert.SetValueGapArr(new <Number>[1.0, 100.0, 0.1, 10.0]);
	_rxsipVert.SetFixedNum(1);
//	_rxsipVert.SetMinValue(0.0);
//	_rxsipVert.SetMaxValue(0.0);
//	_rxsipVert.SetValue(0.0);	
//	trace('##_rxsipVert: {{');
//	trace(_rxsipVert.ToString());
//	trace('}}');
	
	
	
	_rxsipHori = new RxScrollInput(
		_owrt['mvc_rxsipHori'], RxScrollbar.TYPE_HORIZONTAL,
			500, 1.0, 0.0, pf_rxsipHori__cbf);
	_rxsipHori.SetValueGapArr(new <Number>[1.0, 100.0, 0.1, 10.0]);
	_rxsipHori.SetFixedNum(1);
//	_rxsipHori.SetMinValue(0.0);
//	_rxsipHori.SetMaxValue(1.0);	
//	_rxsipHori.SetValue(0.0);
//	trace('##_rxsipHori: {{');
//	trace(_rxsipHori.ToString());
//	trace('}}');

	
	
	
	_rxsipScale = new RxScrollInput(
		_owrt['mvc_rxsipScale'], RxScrollbar.TYPE_HORIZONTAL,
			334, 0.1, 0.0, pf_rxsipScale__cbf);
	_rxsipScale.SetMinValue(0.1);
	_rxsipScale.SetMaxValue(10.0);
	_rxsipScale.SetValue(1.0);
	_rxsipScale.SetValueGapArr(new <Number>[0.01, 1.0, 0.001, 0.1]);
	_rxsipScale.SetFixedNum(3);
//	trace('##_rxsipScale: {{');
//	trace(_rxsipScale.ToString());
//	trace('}}');
	
	
	
	_rxsipRotate = new RxScrollInput(
		_owrt['mvc_rxsipRotate'], RxScrollbar.TYPE_HORIZONTAL,
			334, 0.1, 0.0, pf_rxsipRotate__cbf);
	_rxsipRotate.SetMinValue(0.0);
	_rxsipRotate.SetMaxValue(RxGeom.FullAngle);
	_rxsipRotate.SetValue(0.0);
	_rxsipRotate.SetValueGapArr(new <Number>[1.0, 100.0, 0.1, 10.0]);
	_rxsipRotate.SetFixedNum(1);
//	trace('##_rxsipRotate: {{');
//	trace(_rxsipRotate.ToString());
//	trace('}}');
	
	
	
	
	_sprAllInfo = _owrt['mvcAllInfo'];
	_sprAllInfo.mouseChildren = false;
	_sprAllInfo.mouseEnabled = false;
	
	
	
	_stg.addEventListener(Event.RESIZE, pf_stage__resize);	
	pf_stage__resize(null);
	
	
	_sprArea.addEventListener(MouseEvent.MOUSE_WHEEL, pf_sprArea__mouseWheel);
	_sprArea.addEventListener(MouseEvent.MOUSE_DOWN, pf_sprArea__mouseDown);
	
	
	_stg.addEventListener(KeyboardEvent.KEY_DOWN,
		function(te:KeyboardEvent):void {
			if (te.keyCode === Keyboard.LEFT)
			{//여기부터
			}
		});
}


var _owrt:Sprite = this;
var _stg:Stage;


var _rctArea:Rectangle;

var _sprArea:Sprite;
var _sprMask:Sprite;
var _sprImg:Sprite;

var _sprGrpCont:Sprite;
var _grp:Graphics;

var _sprBorder:Sprite;
var _sprCrossHead:Sprite;



var _rxvt:RxVisualTransformer;

var _rxsipVert:RxScrollInput;
var _rxsipHori:RxScrollInput;

var _rxsipScale:RxScrollInput;
var _rxsipRotate:RxScrollInput;


var _sprAllInfo:Sprite;




pf_InitOnce();
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



