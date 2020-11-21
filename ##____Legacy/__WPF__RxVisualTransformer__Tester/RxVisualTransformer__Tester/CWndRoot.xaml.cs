namespace RxVisualTransformer__Tester
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Windows;
    using System.Windows.Controls;
    using System.Windows.Data;
    using System.Windows.Documents;
    using System.Windows.Input;
    using System.Windows.Media;
    using System.Windows.Media.Imaging;
    using System.Windows.Navigation;
    using System.Windows.Shapes;
    using System.Diagnostics;



    public sealed partial class CWndRoot : Window
    {
        public CWndRoot()
        {
            InitializeComponent();

            Loaded += pf_Loaded;
        }

        private void pf_Loaded(object tsd, RoutedEventArgs tea)
        {
            SizeChanged += pf_SizeChanged;
            KeyDown += pf_KeyDown;

            pf_SizeChanged(null, null);
        }

        protected override void OnContentRendered(EventArgs tea)
        {
            base.OnContentRendered(tea);

            ResizeMode = ResizeMode.CanResize;
            SizeToContent = SizeToContent.Manual;
            _grdrt.Width = double.NaN;
            _grdrt.Height = double.NaN;
        }

        //protected override void OnRender(DrawingContext tdc)
        //{
        //    base.OnRender(tdc);

        //    if (!_rctBorder.IsEmpty)
        //    {
        //        Brush tbrs = Brushes.Red.Clone();
        //        tbrs.Opacity = 0.25;
        //        tdc.DrawRectangle(tbrs, null, _rctBorder);
        //    }
        //}

        private Rect _rctBorder;
        private void pf_SizeChanged(object tsd, SizeChangedEventArgs tea)
        {
            //var ta = VisualTreeHelper.GetContentBounds(_rtg1);
            //var tb = VisualTreeHelper.GetDescendantBounds(_rtg1);

            //Rect trct = VisualTreeHelper.GetContentBounds(_rtg1);
            Rect trct = VisualTreeHelper.GetDescendantBounds(_rtg1);
            Size tsz = _cvsrt.RenderSize;
            double tcx = (tsz.Width / 2) - (trct.Width / 2);
            double tcy = (tsz.Height / 2) - (trct.Height / 2);
            //double tcx = trct.Left + (trct.Width / 2);
            //double tcy = trct.Top + (trct.Height / 2);
            _tltf.X = tcx;
            _tltf.Y = tcy;


            /*
            _rctBorder = trct;
            _rctBorder.X = _tltf.X;
            _rctBorder.Y = _tltf.Y;
            _rctBorder.Transform(_tfgrp.Value);
            //_rctBorder = _tfgrp.TransformBounds(_rctBorder);
            //_rctBorder = Rect.Transform(_rctBorder, _tfgrp.Value);
            //InvalidateVisual();
            Debug.WriteLine(_rctBorder);*/


            //_rtgBorder.Width = _rctBorder.Width;
            //_rtgBorder.Height = _rctBorder.Height;
            //Canvas.SetLeft(_rtgBorder, _rctBorder.Left);
            //Canvas.SetTop(_rtgBorder, _rctBorder.Top);
            //_rtgBorder.RenderTransform = _tfgrp;
        }

        private void pf_KeyDown(object tsd, KeyEventArgs tea)
        {
            if (tea.Key == Key.Left)
            {
                _rttf.Angle -= 5;
            }
            else if (tea.Key == Key.Right)
            {
                _rttf.Angle += 5;
            }
            else if (tea.Key == Key.Up)
            {
                _sctf.ScaleX += 0.1;
                _sctf.ScaleY += 0.1;
            }
            else if (tea.Key == Key.Down)
            {
                _sctf.ScaleX -= 0.1;
                _sctf.ScaleY -= 0.1;
            }


            Rect trct = VisualTreeHelper.GetContentBounds(_rtg1);
            _rctBorder = trct;
            //_rctBorder.Transform(_tfgrp.Value);
            //_rctBorder = _tfgrp.TransformBounds(_rctBorder);
            _tfgrp.Value.
            _rctBorder = Rect.Transform(_rctBorder, _tfgrp.Value);
            _rctBorder.X = _tltf.X;
            _rctBorder.Y = _tltf.Y;
            Debug.WriteLine(_rctBorder);
            _bdr1.DrawRect(_rctBorder);

            //_rtgBorder.Width = _rctBorder.Width;
            //_rtgBorder.Height = _rctBorder.Height;
            //Canvas.SetLeft(_rtgBorder, 10);
            //Canvas.SetTop(_rtgBorder, 10);
            //Debug.WriteLine(_rtgBorder.RenderTransform);
        }
    }


    public class CBorderRender : FrameworkElement
    {
        protected override void OnRender(DrawingContext tdc)
        {
            base.OnRender(tdc);

            if (!_rct.IsEmpty)
            {
                Brush tbrs = Brushes.Red.Clone();
                tbrs.Opacity = 0.25;
                tdc.DrawRectangle(tbrs, null, _rct);
            }
        }

        private Rect _rct;
        public void DrawRect(Rect trct)
        {
            _rct = trct;
            InvalidateVisual();
        }
    }
}
