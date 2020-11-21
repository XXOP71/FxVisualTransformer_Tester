
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;



var _owrt:Sprite = this;
var _stage:Stage = _owrt.stage;


var _spr_cpt:Sprite = _owrt['mvcCenterPoint'];
_spr_cpt.mouseChildren = false;
_spr_cpt.mouseEnabled = false;

var _spr_pt1:Sprite = _owrt['mvcPoint1'];
_spr_pt1.mouseChildren = false;
_spr_pt1.mouseEnabled = false;

var _vtdos:Vector.<DisplayObject>;


function pf_GetPointArr():void
{
    if (_vtdos == null)
    {
        _vtdos = new Vector.<DisplayObject>();

        var tl:int = _owrt.numChildren;
        for (var i:int = 0; i < tl; i++)
        {
            var tdo:DisplayObject = _owrt.getChildAt(i);
            //trace(tdo.name);
            if (tdo.name !== 'mvcCenterPoint')
            {
                _vtdos.push(tdo);
            }
        }
    }
}


_stage.addEventListener(Event.ENTER_FRAME,
    function(te:Event):void {
        pf_GetPointArr();

        var tcpt:Point = new Point(_spr_cpt.x, _spr_cpt.y);
        var trd:Number = Math.PI / 32;
        for each (var tdo:DisplayObject in _vtdos)
        {
            var ttpt:Point = new Point(tdo.x, tdo.y);
            var tnpt:Point = FxGeometry.GetRcpt(tcpt, ttpt, trd);
            //trace(tnpt);
            tdo.x = tnpt.x;
            tdo.y = tnpt.y;
        }







        /*
        var tcpt:Point = new Point(_spr_cpt.x, _spr_cpt.y);
        var ttpt:Point = new Point(_spr_pt1.x, _spr_pt1.y);
        var trd:Number = Math.PI / 32;

        var tnpt:Point = FxGeometry.GetRcpt(tcpt, ttpt, trd);
        trace(tnpt);
        _spr_pt1.x = tnpt.x;
        _spr_pt1.y = tnpt.y;
        */






        /*
        var tcpt:Point = new Point(_spr_cpt.x, _spr_cpt.y);
        var ttpt:Point = new Point(_spr_pt1.x, _spr_pt1.y);
        var trd:Number = Math.PI / 32;

        var _mtr:Matrix = new Matrix();
        _mtr.translate(-tcpt.x, -tcpt.y);
        _mtr.rotate(trd);
        _mtr.translate(tcpt.x, tcpt.y);
        //trace('_mtr:', _mtr);

        var tnpt:Point = _mtr.transformPoint(ttpt);
        trace(tnpt);
        _spr_pt1.x = tnpt.x;
        _spr_pt1.y = tnpt.y;
        */



        /*
        var tcx:Number = _spr_cpt.x,
            tcy:Number = _spr_cpt.y;
//		var tcx:Number = _owrt.mouseX,
//			tcy:Number = _owrt.mouseY;
        var tfx:Number = _spr_pt1.x - tcx,
            tfy:Number = _spr_pt1.y - tcy;

        var _mtr:Matrix = new Matrix();
        //trace(_mtr);
        _mtr.translate(tfx, tfy);
        _mtr.rotate(Math.PI / 32);
        _mtr.translate(tcx, tcy);

        _spr_pt1.transform.matrix = _mtr;
        */
    });



