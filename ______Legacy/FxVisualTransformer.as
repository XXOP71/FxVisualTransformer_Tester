package
{
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.geom.Point;



    public class FxVisualTransformer
    {
        //====================================================================================================
        // ##
        //====================================================================================================
        public function FxVisualTransformer(ttdo:DisplayObject)
        {
            _tdo = ttdo;
            pf_RenewBounds();
            pf_RenewMatrix();
        }

        //-- Target DisplayObject
        private var _tdo:DisplayObject;

        //-- Target Bounds
        private var _rct:Rectangle;

        //-- Target Matrix
        private var _mtr:Matrix;



        private function pf_RenewBounds():void
        {
            _rct = FxGeometry.GetBounds(_tdo);
            //trace('_rct:', _rct);
        }

        private function pf_RenewMatrix():void
        {
            _mtr = FxGeometry.GetMatrix(_tdo);
            //trace('_mtr:', _mtr);
        }

        private function pf_ApplyMatrix():void
        {
            FxGeometry.SetMatrix(_tdo, _mtr);
            //trace('_mtr:', _mtr);
            pf_RenewBounds();
        }
        //====================================================================================================



        //====================================================================================================
        // ##
        //====================================================================================================
        public function GetTarget():DisplayObject
        {
            return _tdo;
        }

        public function GetBounds():Rectangle
        {
            return _rct;
        }

        public function GetMatrix():Matrix
        {
            return _mtr;
        }

        public function DrawBounds(tgrp:Graphics):void
        {
            tgrp.clear();
            tgrp.lineStyle(5, 0xff0000, 0.35);
            tgrp.beginFill(0x00ff00, 0.15);
            tgrp.drawRect(_rct.x, _rct.y, _rct.width, _rct.height);
            tgrp.moveTo(_rct.left, _rct.top);
            tgrp.lineTo(_rct.right, _rct.bottom);
            tgrp.moveTo(_rct.left, _rct.bottom);
            tgrp.lineTo(_rct.right, _rct.top);
        }
        //====================================================================================================



        //====================================================================================================
        // ##
        //====================================================================================================
        public function GetRadian1():Number
        {
            return FxGeometry.GetRadian1(_mtr);
        }

        public function GetRadian2():Number
        {
            return FxGeometry.GetRadian2(_mtr);
        }

        public function GetScaleX():Number
        {
            return FxGeometry.GetScaleX(_mtr);
        }

        public function GetScaleY():Number
        {
            return FxGeometry.GetScaleY(_mtr);
        }

        public function GetLeft():Number
        {
            return FxGeometry.GetLeft(_rct);
        }

        public function GetTop():Number
        {
            return FxGeometry.GetTop(_rct);
        }

        public function GetRight():Number
        {
            return FxGeometry.GetRight(_rct);
        }

        public function GetBottom():Number
        {
            return FxGeometry.GetBottom(_rct);
        }

        public function GetLeftCenter():Number
        {
            return FxGeometry.GetLeftCenter(_rct);
        }

        public function GetTopCenter():Number
        {
            return FxGeometry.GetTopCenter(_rct);
        }

        public function GetCenterPoint():Point
        {
            return FxGeometry.GetCenterPoint(_rct);
        }

        public function GetRotationToRadian(tdo:DisplayObject):Number
        {
            return FxGeometry.GetRotationToRadian(_tdo);
        }
        //====================================================================================================



        //====================================================================================================
        // ##
        //====================================================================================================
        //~~~~~~~~~~
        public function MoveLeft(tv:Number):void
        {
            FxGeometry.MoveLeft(_rct, _mtr, tv);
            pf_ApplyMatrix();
        }

        public function MoveTop(tv:Number):void
        {
            FxGeometry.MoveTop(_rct, _mtr, tv);
            pf_ApplyMatrix();
        }

        public function MoveLeftTop(tx:Number, ty:Number):void
        {
            FxGeometry.MoveLeftTop(_rct, _mtr, tx, ty);
            pf_ApplyMatrix();
        }
        //~~~~~~~~~~


        //~~~~~~~~~~
        public function MoveRight(tv:Number):void
        {
            FxGeometry.MoveRight(_rct, _mtr, tv);
            pf_ApplyMatrix();
        }

        public function MoveBottom(tv:Number):void
        {
            FxGeometry.MoveBottom(_rct, _mtr, tv);
            pf_ApplyMatrix();
        }

        public function MoveRightBottom(tx:Number, ty:Number):void
        {
            FxGeometry.MoveRightBottom(_rct, _mtr, tx, ty);
            pf_ApplyMatrix();
        }
        //~~~~~~~~~~


        //~~~~~~~~~~
        public function MoveLeftCenter(tv:Number):void
        {
            FxGeometry.MoveLeftCenter(_rct, _mtr, tv);
            pf_ApplyMatrix();
        }

        public function MoveTopCenter(tv:Number):void
        {
            FxGeometry.MoveTopCenter(_rct, _mtr, tv);
            pf_ApplyMatrix();
        }

        public function MoveCenter(tx:Number, ty:Number):void
        {
            FxGeometry.MoveCenter(_rct, _mtr, tx, ty);
            pf_ApplyMatrix();
        }
        //~~~~~~~~~~


        //~~~~~~~~~~
        public function RotateAt(tx:Number, ty:Number, trd:Number):void
        {
            FxGeometry.RotateAt(_mtr, tx, ty, trd);
            pf_ApplyMatrix();
        }

        public function RotateCenter(trd:Number):void
        {
            FxGeometry.RotateCenter(_rct, _mtr, trd);
            pf_ApplyMatrix();
        }

        public function SetRotateAt(tx:Number, ty:Number, trd:Number):void
        {
            FxGeometry.SetRotateAt(_mtr, tx, ty, trd);
            pf_ApplyMatrix();
        }

        public function SetRotateCenter(trd:Number):void
        {
            FxGeometry.SetRotateCenter(_rct, _mtr, trd);
            pf_ApplyMatrix();
        }
        //~~~~~~~~~~


        //~~~~~~~~~~
        public function ScaleAt(tx:Number, ty:Number, tsx:Number, tsy:Number):void
        {
            FxGeometry.ScaleAt(_mtr, tx, ty, tsx, tsy);
            pf_ApplyMatrix();
        }

        public function ScaleCenter(tsx:Number, tsy:Number):void
        {
            FxGeometry.ScaleCenter(_rct, _mtr, tsx, tsy);
            pf_ApplyMatrix();
        }

        public function SetScaleAt(tx:Number, ty:Number, tsx:Number, tsy:Number):void
        {
            FxGeometry.SetScaleAt(_mtr, tx, ty, tsx, tsy);
            pf_ApplyMatrix();
        }

        public function SetScaleCenter(tsx:Number, tsy:Number):void
        {
            FxGeometry.SetScaleCenter(_rct, _mtr, tsx, tsy);
            pf_ApplyMatrix();
        }
        //~~~~~~~~~~
        //====================================================================================================

    }
}
