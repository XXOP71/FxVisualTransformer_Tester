import flash.display.Graphics;
import flash.display.SimpleButton;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;







function pf_ImageSizeUpdate():void
{
	var rctArea:Rectangle = _sprArea.getBounds(_owrt);
	var rctImg:Rectangle = _fxvt.GetBounds();
	var tmx:Number;
	var tmy:Number;




	var tmh:Number = rctArea.height;
	var tih:Number = rctImg.height;
	var tssrh:Number = tmh / tih;
	_fxsipv.GetScrollbar().SetScrollSizeRatio(tssrh);
	if (tssrh < 1)
	{
		var tssh:Number = tih - tmh;
		var tprh:Number = _fxsipv.GetScrollbar().GetPositionRatio();
		var tiy:Number = rctArea.top - (tssh * tprh);
		//trace(tssh, tprh, tiy);

		_fxvt.MoveTop(tiy);
		_fxvt.DrawBounds(_grp);
	}
	else
	{
		tmy = FxGeometry.GetTopCenter(rctArea);
		_fxvt.MoveTopCenter(tmy);
		_fxvt.DrawBounds(_grp);
	}


	var tmw:Number = rctArea.width;
	var tiw:Number = rctImg.width;
	var tssrw:Number = tmw / tiw;
	_fxsiph.GetScrollbar().SetScrollSizeRatio(tssrw);
	if (tssrw < 1)
	{
		var tssw:Number = tiw - tmw;
		var tprw:Number = _fxsiph.GetScrollbar().GetPositionRatio();
		var tix:Number = rctArea.left - (tssw * tprw);
		//trace(tssw, tprw, tix);

		_fxvt.MoveLeft(tix);
		_fxvt.DrawBounds(_grp);
	}
	else
	{
		tmx = FxGeometry.GetLeftCenter(rctArea);
		_fxvt.MoveLeftCenter(tmx);
		_fxvt.DrawBounds(_grp);
	}
}


function pp_fxsi_ecb__v(te:Event = null):void
{
	var rctArea:Rectangle = _sprArea.getBounds(_owrt);
	var rctImg:Rectangle = _fxvt.GetBounds();

	var tssrh:Number = _fxsipv.GetScrollbar().GetScrollSizeRatio();
	//trace('tssrh:', tssrh);
	if (tssrh < 1)
	{
		var tmh:Number = rctArea.height;
		var tih:Number = rctImg.height;
		var tssh:Number = tih - tmh;
		var tprh:Number = _fxsipv.GetScrollbar().GetPositionRatio();
		//trace(tprh);
		var tiy:Number = rctArea.top - (tssh * tprh);
		//trace(tiy);

		_fxvt.MoveTop(tiy);
		_fxvt.DrawBounds(_grp);
	}
}


function pp_fxsi_ecb__h(te:Event = null):void
{
	var rctArea:Rectangle = _sprArea.getBounds(_owrt);
	var rctImg:Rectangle = _fxvt.GetBounds();

	var tssrw:Number = _fxsiph.GetScrollbar().GetScrollSizeRatio();
	//trace('tssrw:', tssrw);
	if (tssrw < 1)
	{
		var tmw:Number = rctArea.width;
		var tiw:Number = rctImg.width;
		var tssw:Number = tiw - tmw;
		var tprw:Number = _fxsiph.GetScrollbar().GetPositionRatio();
		//trace(tprw);
		var tix:Number = rctArea.left - (tssw * tprw);
		//trace(tix);

		_fxvt.MoveLeft(tix);
		_fxvt.DrawBounds(_grp);
	}
}



function pf__fxsbScale_Update():void
{
	var ts:Number = _fxsipScale.GetVal();
	//trace(ts);
	_fxvt.SetScaleCenter(ts, ts);
	_fxvt.DrawBounds(_grp);

	pf_ImageSizeUpdate();
}

function pf__fxsbRotation_Update():void
{
	var trd:Number = _fxsipRotation.GetVal();
	//trace(trd);
	_fxvt.SetRotateCenter(trd);
	_fxvt.DrawBounds(_grp);

	pf_ImageSizeUpdate();
}


function pf__stage_resize(te:Event):void
{
	var tsw:Number = _stage.stageWidth;
	var tsh:Number = _stage.stageHeight;

	_rctArea.width = tsw - 40;
	_rctArea.height = tsh - 140;

	_sprBorder.width = _rctArea.width;
	_sprBorder.height = _rctArea.height;

	var ttw:Number = _rctArea.width - 20;
	var tth:Number = _rctArea.height - 20;
	var ttx:Number = 10;
	var tty:Number = 10;
	_sprArea.width = ttw;
	_sprArea.height = tth;
	_sprArea.x = ttx;
	_sprArea.y = tty;

	_sprMask.width = ttw;
	_sprMask.height = tth;
	_sprMask.x = ttx;
	_sprMask.y = tty;


	_fxsipv.GetCont().x = _rctArea.right;
	_fxsipv.GetScrollbar().SetSize(_rctArea.height);
	_fxsipv.SetTextBoxPos(NaN, tsh - 30);

	_fxsiph.GetCont().y = _rctArea.height;
	_fxsiph.GetScrollbar().SetSize(_rctArea.width);
	_fxsiph.SetTextBoxPos(tsw - 142, NaN);


	tty = _rctArea.height + 80;
	_fxsipScale.GetCont().y = tty;

	tty = _rctArea.height + 110;
	_fxsipRotation.GetCont().y = tty;


	pf_ImageSizeUpdate();
}


function pf_InitOnce():void
{
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



	_fxvt = new FxVisualTransformer(_sprImg);
	_fxvt.DrawBounds(_grp);


	_fxsipScale = new FxScrollInput(_owrt['mvc_fxsipScale'], FxScrollbar.TYPE_HORIZONTAL,
						'mvc_fxsb', 'txb',
						300, 0.1, 0.0,
						0.3, 3.0, 1.0,
						0.1, 10.0, 0.01, 1.0,
						2, pf__fxsbScale_Update);

	_fxsipRotation = new FxScrollInput(_owrt['mvc_fxsipRotation'], FxScrollbar.TYPE_HORIZONTAL,
						'mvc_fxsb', 'txb',
						300, 0.1, 0.0,
						0.0, FxGeometry.FullRadian, 0.0,
						0.1, 10.0, 0.01, 1.0,
						2, pf__fxsbRotation_Update);


	_fxsipv = new FxScrollInput(_owrt['mvc_fxsipv'], FxScrollbar.TYPE_VERTICAL,
						'mvc_fxsb', 'txb',
						600, 1.0, 0.0,
						0.0, 1.0, 0.5,
						0.01, 1.0, 0.001, 0.1,
						2, pp_fxsi_ecb__v);

	_fxsiph = new FxScrollInput(_owrt['mvc_fxsiph'], FxScrollbar.TYPE_HORIZONTAL,
						'mvc_fxsb', 'txb',
						700, 1.0, 0.0,
						0.0, 1.0, 0.5,
						0.01, 1.0, 0.001, 0.1,
						2, pp_fxsi_ecb__h);



	_stage = _owrt.stage;
	_stage.scaleMode = StageScaleMode.NO_SCALE;
	_stage.align = StageAlign.TOP_LEFT;
	_stage.addEventListener(Event.RESIZE, pf__stage_resize);
	_rctArea = new Rectangle(0, 0, 0, 0);

	pf__stage_resize(null);




	_sprArea.addEventListener(MouseEvent.CLICK,
		function(te:MouseEvent):void {
			//var tmx:Number = _owrt.mouseX;
			//var tmy:Number = _owrt.mouseY;

			//_fxvt.MoveLeft(tmx);
			//_fxvt.MoveTop(tmy);
			//_fxvt.MoveLeftTop(tmx, tmy);

			//_fxvt.MoveRight(tmx);
			//_fxvt.MoveBottom(tmy);
			//_fxvt.MoveRightBottom(tmx, tmy);

			//_fxvt.MoveLeftCenter(tmx);
			//_fxvt.MoveTopCenter(tmy);
			//_fxvt.MoveCenter(tmx, tmy);

			//_fxvt.DrawBounds(_grp);
		});


	_sprArea.addEventListener(MouseEvent.MOUSE_WHEEL,
		function(te:MouseEvent):void {
			if (te.altKey)
			{
				_fxsipRotation.CallMouseWheelHandler(te);
			}
			else
			{
				_fxsipScale.CallMouseWheelHandler(te);
			}
		});


	_sprArea.addEventListener(MouseEvent.MOUSE_MOVE,
		function(te:MouseEvent):void {
			/*
			//trace(_owrt.mouseX, _owrt.mouseY);
			var tmx:Number = _owrt.mouseX;
			var tmy:Number = _owrt.mouseY;
			
			var rctArea:Rectangle = _sprArea.getBounds(_owrt);
			var rctImg:Rectangle = _fxvt.GetBounds();
			
			//_fxvt.MoveCenter(tmx, tmy);
			
			trace();
			*/
			/*
			var tmx:Number = _owrt.mouseX;
			var tmy:Number = _owrt.mouseY;
			
			var rctArea:Rectangle = _sprArea.getBounds(_owrt);
			var rctImg:Rectangle = _fxvt.GetBounds();
			
			var tmh:Number = rctArea.height;
			var tih:Number = rctImg.height;
			var tssrh:Number = tmh / tih;
			_fxsipv.GetScrollbar().SetScrollSizeRatio(tssrh);
			if (tssrh < 1)
			{
				var tssh:Number = tih - tmh;
				var tprh:Number = _fxsipv.GetScrollbar().GetPositionRatio();
				var tiy:Number = rctArea.top - (tssh * tprh);
				//trace(tssh, tprh, tiy);
		
				_fxvt.MoveTop(tiy);
				_fxvt.DrawBounds(_grp);
			}
			else
			{
				tmy = FxGeometry.GetTopCenter(rctArea);
				_fxvt.MoveTopCenter(tmy);
				_fxvt.DrawBounds(_grp);
			}*/
		});
		
}


var _owrt:Sprite = this;
var _stage:Stage;
var _rctArea:Rectangle;

var _sprArea:Sprite;
var _sprMask:Sprite;
var _sprImg:Sprite;

var _sprGrpCont:Sprite;
var _grp:Graphics;

var _sprBorder:Sprite;


var _fxvt:FxVisualTransformer;

var _fxsipScale:FxScrollInput;
var _fxsipRotation:FxScrollInput;

var _fxsipv:FxScrollInput;
var _fxsiph:FxScrollInput;





pf_InitOnce();




