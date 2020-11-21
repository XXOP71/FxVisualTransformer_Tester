package
{
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;




    public final class FxScrollbar
    {
        public static const TYPE_VERTICAL:String = 'vertical';
        public static const TYPE_HORIZONTAL:String = 'horizontal';
        public static const ET_UPDATE:String = 'update';


        private static const _amg:Number = 10;
        private static const _amga:Number = 20;
        private static const _tmg:Number = 3;
        private static const _tmga:Number = _tmg * 2;

        private static const _minsz:Number = 40;
        private static const _maxsz:Number = 4000;



        public function FxScrollbar(ttp:String, tow:Sprite,
                tsz:Number = 400, tssr:Number = 1.0, tpr:Number = 0.0,
                tfevt:Function = null)
        {
            _type = ttp;

            _owner = tow;
            _grp = _owner.graphics;
            _stage = _owner.stage;
            //trace(ttp, tow, tsz, tfevt);

            _rctTrack = _owner.getBounds(_owner.parent)
            //trace(_rctTrack);
            if (_type == TYPE_VERTICAL)
                _rctTrack.height = tsz;
            else if (_type == TYPE_HORIZONTAL)
                _rctTrack.width = tsz;
            _rctTrack.x = 0;
            _rctTrack.y = 0;
            _rctScrollArea = _rctTrack.clone();
            _rctThumb = _rctTrack.clone();
            //trace('~~~1');

            _owner.scaleX = 1;
            _owner.scaleY = 1;
            _owner.removeChildren(0);
            _owner.mouseChildren = false;
            _owner.buttonMode = true;
            //trace('~~~2');

            _scrollSizeRatio = tssr;
            _positionRatio = tpr;
            _enabled = _owner.mouseEnabled;
            //trace('~~~3');

            _fevt = tfevt;


            pf_UpdateRects();
            pf_EnabledCheck();
            //trace('~~~4');

            _owner.addEventListener(MouseEvent.MOUSE_DOWN, pf_MouseDown);
            //trace('~~~5');
        }
        private var _type:String;
        private var _owner:Sprite;
        private var _fevt:Function;
        private var _grp:Graphics;
        private var _stage:Stage;

        private var _rctTrack:Rectangle;
        private var _rctScrollArea:Rectangle;
        private var _rctThumb:Rectangle;

        private var _scrollSizeRatio:Number;
        private var _positionRatio:Number;
        private var _enabled:Boolean;




        private function pf_DrawRects():void
        {
            var tx:Number, ty:Number, tw:Number, th:Number;
            _grp.clear();


            tx = _rctTrack.x,
            ty = _rctTrack.y,
            tw = _rctTrack.width,
            th = _rctTrack.height;
            _grp.beginFill(0xff6600, 1);
            _grp.drawRect(tx, ty, tw, th);
            _grp.endFill();


            tx = _rctScrollArea.x - 5,
            tx = _rctScrollArea.x,
            ty = _rctScrollArea.y,
            tw = _rctScrollArea.width,
            th = _rctScrollArea.height;
            _grp.beginFill(0x88ff11, 0.75);
            _grp.drawRect(tx, ty, tw, th);
            _grp.endFill();


            tx = _rctThumb.x + _tmg,
            ty = _rctThumb.y + _tmg,
            tw = _rctThumb.width - _tmga,
            th = _rctThumb.height - _tmga;
            // tx = _rctThumb.x,
            // ty = _rctThumb.y,
            // tw = _rctThumb.width,
            // th = _rctThumb.height;
            _grp.beginFill(0xffffff, 1);
            _grp.drawRoundRect(tx, ty, tw, th, 10, 10);
            _grp.endFill();

            // _grp.lineStyle(1, 0xff0000);
            // _grp.moveTo(tx, ty + (th / 2));
            // _grp.lineTo(tx + tw, ty + (th / 2));
        }

        private function pf_UpdateRects():void
        {
            if (_type == TYPE_VERTICAL)
            {
                var tth:Number = _rctTrack.height - _amga;
                if (tth < _amga) tth = _amga;

                var tsah:Number = tth * (1 - _scrollSizeRatio);
                //trace(tsah);

                _rctScrollArea.height = tsah;
                _rctScrollArea.y = ((tth / 2) - (tsah / 2)) + _amg;
                _rctThumb.height = (tth * _scrollSizeRatio) + _amga;
                _rctThumb.y = _rctScrollArea.height * _positionRatio;

                pf_DrawRects();
            }
            else if (_type == TYPE_HORIZONTAL)
            {
                var ttw:Number = _rctTrack.width - _amga;
                if (ttw < _amga) ttw = _amga;

                var tsaw:Number = ttw * (1 - _scrollSizeRatio);
                //trace(tsaw);

                _rctScrollArea.width = tsaw;
                _rctScrollArea.x = ((ttw / 2) - (tsaw / 2)) + _amg;
                _rctThumb.width = (ttw * _scrollSizeRatio) + _amga;
                _rctThumb.x = _rctScrollArea.width * _positionRatio;

                pf_DrawRects();
            }
        }

        private function pf_UpdatePosition():void
        {
            if (_type == TYPE_VERTICAL)
            {
                _rctThumb.y = _rctScrollArea.height * _positionRatio;
                //trace('_rctThumb:', _rctThumb);
                pf_DrawRects();
            }
            else if (_type == TYPE_HORIZONTAL)
            {
                _rctThumb.x = _rctScrollArea.width * _positionRatio;
                //trace('_rctThumb:', _rctThumb);
                pf_DrawRects();
            }
        }



        private function pf_Deactivate(te:Event):void
        {
            pf_MouseUp(null);
        }

        private function pf_MouseMove(te:MouseEvent):void
        {
            var tv:Number;
            var tf:Number;

            if (_type == TYPE_VERTICAL)
            {
                tv = _owner.mouseY - _rctScrollArea.y;
                tf = _rctScrollArea.height;
            }
            else if (_type == TYPE_HORIZONTAL)
            {
                tv = _owner.mouseX - _rctScrollArea.x;
                tf = _rctScrollArea.width;
            }

            if (tv < 0) tv = 0;
            else if (tv > tf) tv = tf;
            //trace(tv, tf);

            if (tf == 0)
                _positionRatio = 0;
            else
                _positionRatio = tv / tf;
            //trace(tv, _positionRatio, tf);

            pf_UpdatePosition();

            if (_fevt != null) _fevt(new Event(ET_UPDATE));


            if (te != null) te.updateAfterEvent();
        }

        private function pf_MouseUp(te:MouseEvent):void
        {
            _stage.removeEventListener(MouseEvent.MOUSE_UP, pf_MouseUp);
            _stage.removeEventListener(Event.DEACTIVATE, pf_Deactivate);
            _stage.removeEventListener(MouseEvent.MOUSE_MOVE, pf_MouseMove);
        }

        private function pf_MouseDown(te:MouseEvent):void
        {
            _stage.addEventListener(MouseEvent.MOUSE_UP, pf_MouseUp);
            _stage.addEventListener(Event.DEACTIVATE, pf_Deactivate);
            _stage.addEventListener(MouseEvent.MOUSE_MOVE, pf_MouseMove);
            pf_MouseMove(null);
        }


        public function GetSize():Number
        {
            if (_type == TYPE_VERTICAL)
                return _rctTrack.height;
            else if (_type == TYPE_HORIZONTAL)
                return _rctTrack.width;
            return NaN;
        }
        public function SetSize(tv:Number):void
        {
            if (_type == TYPE_VERTICAL)
            {
                if (tv < _minsz)
                    tv = _minsz;
                else if (tv > _maxsz)
                    tv = _maxsz;

                if (tv == _rctTrack.height) return;
                _rctTrack.height = tv;
                pf_UpdateRects();
            }
            else if (_type == TYPE_HORIZONTAL)
            {
                if (tv < _minsz)
                    tv = _minsz;
                else if (tv > _maxsz)
                    tv = _maxsz;

                if (tv == _rctTrack.width) return;
                _rctTrack.width = tv;
                pf_UpdateRects();
            }
        }

        public function GetScrollSizeRatio():Number
        {
            return _scrollSizeRatio;
        }
        public function SetScrollSizeRatio(tr:Number):void
        {
            if (tr < 0) tr = 0;
            else if (tr > 1) tr = 1;

            if (tr == _scrollSizeRatio) return;
            _scrollSizeRatio = tr;
            pf_UpdateRects();
            pf_EnabledCheck();
        }

        public function GetPositionRatio():Number
        {
            return _positionRatio;
        }
        public function SetPositionRatio(tr:Number):void
        {
            if (tr < 0) tr = 0;
            else if (tr > 1) tr = 1;

            if (tr == _positionRatio) return;
            _positionRatio = tr;
            pf_UpdatePosition();
        }


        private function pf_EnabledCheck():void
        {
            if (_scrollSizeRatio < 1)
                SetEnabled(true);
            else
                SetEnabled(false);
        }
        public function GetEnabled():Boolean
        {
            return _enabled;
        }
        public function SetEnabled(tb:Boolean):void
        {
            if (_enabled == tb) return;
            _enabled = tb;
            if (_enabled)
            {
                _owner.alpha = 1;
                _owner.mouseEnabled = true;
            }
            else
            {
                _owner.alpha = 0.15;
                _owner.mouseEnabled = false;
            }
        }


        public function GetX():Number
        {
            return _owner.x;
        }
        public function SetX(tv:Number):void
        {
            _owner.x = tv;
        }


        public function GetY():Number
        {
            return _owner.y;
        }
        public function SetY(tv:Number):void
        {
            _owner.y = tv;
        }

    }
}

