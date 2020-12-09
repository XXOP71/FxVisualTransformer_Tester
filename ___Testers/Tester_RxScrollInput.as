import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import RxGraphicsLibrary.Controls.RxScrollbar;
import RxGraphicsLibrary.Controls.RxScrollInput;
import RxGraphicsLibrary.Controls.RxVisualTransformer;









//::
function pf_ImageScrollSizeUpdate(tb:Boolean):void
{
	var rctArea:Rectangle = _sprArea.getBounds(_owrt);
	var rctImg:Rectangle = _rxvt.GetRect();
	
	_rxsipVert.SetCalcValues(rctArea.height, rctImg.height);
	_rxsipHori.SetCalcValues(rctArea.width, rctImg.width);
	
	pf_rxsipVert__cbf();
	pf_rxsipHori__cbf();
}


//::
function pf_rxsipVert__cbf():void
{
	var rctArea:Rectangle = _sprArea.getBounds(_owrt);
	var rctImg:Rectangle = _rxvt.GetRect();
	
	var tssrh:Number = _rxsipVert.GetScrollSizeRatio();
	if (tssrh < 1)
	{
		var tiy:Number = rctArea.top - _rxsipVert.GetValue();
	
		_rxvt.MoveTop(tiy);
		_rxvt.ApplyMatrix();
		//_rxvt.DrawBorders(_grp);
	}
}

//::
function pf_rxsipHori__cbf():void
{
	var rctArea:Rectangle = _sprArea.getBounds(_owrt);
	var rctImg:Rectangle = _rxvt.GetRect();	
	
	var tssrw:Number = _rxsipHori.GetScrollSizeRatio();
	if (tssrw < 1)
	{
		var tix:Number = rctArea.left - _rxsipHori.GetValue();
	
		_rxvt.MoveLeft(tix);
		_rxvt.ApplyMatrix();
		//_rxvt.DrawBorders(_grp);
	}
}


//::
function pf_stage__resize(te:Event):void
{
	pf_ImageScrollSizeUpdate(true);
}


//::
function pf_InitOnce():void
{
	_stg = _owrt.stage;
	_stg.align = StageAlign.TOP_LEFT;
	_stg.scaleMode = StageScaleMode.NO_SCALE;
	
	
	
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
	
	
	
	
	_rxvt = new RxVisualTransformer(_sprImg);
	//_rxvt.DrawBorders(_grp);
	
	
	
	_rxsipVert = new RxScrollInput(
		_owrt['mvc_rxsipVert'], RxScrollbar.TYPE_VERTICAL,
			500, 1.0, 0.0, pf_rxsipVert__cbf);
	_rxsipVert.SetValueGapArr(new <Number>[1.0, 100.0, 0.1, 10.0]);
	_rxsipVert.SetFixedNum(1);
	_rxsipVert.SetMinValue(0.0);
	_rxsipVert.SetMaxValue(1.0);	
	_rxsipVert.SetValue(0.0);	
//	trace('##_rxsipVert: {{');
//	trace(_rxsipVert.ToString());
//	trace('}}');
	
	
	
	_rxsipHori = new RxScrollInput(
		_owrt['mvc_rxsipHori'], RxScrollbar.TYPE_HORIZONTAL,
			500, 1.0, 0.0, pf_rxsipHori__cbf);
	_rxsipHori.SetValueGapArr(new <Number>[1.0, 100.0, 0.1, 10.0]);
	_rxsipHori.SetFixedNum(1);
	_rxsipHori.SetMinValue(0.0);
	_rxsipHori.SetMaxValue(1.0);	
	_rxsipHori.SetValue(0.0);	
//	trace('##_rxsipHori: {{');
//	trace(_rxsipHori.ToString());
//	trace('}}');
	
	
	
	_stg.addEventListener(Event.RESIZE, pf_stage__resize);
	
	pf_stage__resize(null);
}


var _owrt:Sprite = this;
var _stg:Stage;


var _sprArea:Sprite;
var _sprMask:Sprite;
var _sprImg:Sprite;


var _rxvt:RxVisualTransformer;

var _rxsipVert:RxScrollInput;
var _rxsipHori:RxScrollInput;



pf_InitOnce();





