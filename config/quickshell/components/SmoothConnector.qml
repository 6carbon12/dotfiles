import QtQuick
import "../globals"

Canvas {
  id: root

  property int barHeight: 2
  property color color: Theme.darkGray

  // Set to 128px as requested
  property int curveWidth: 32

  onWidthChanged: requestPaint()
  onHeightChanged: requestPaint()
  onColorChanged: requestPaint()
  onCurveWidthChanged: requestPaint()

  onPaint: {
    var ctx = getContext("2d");
    ctx.reset();

    var w = width;
    var h = height;
    var centerY = h / 2;
    var halfBar = barHeight / 2;

    var barTop = centerY - halfBar;
    var barBottom = centerY + halfBar;

    // Safety check: ensure curve doesn't overlap if modules are too close
    var cw = Math.min(curveWidth, w / 2);

    ctx.fillStyle = root.color;
    ctx.beginPath();

    // 1. Top-Left: Start at absolute top of bounding box (0,0)
    ctx.moveTo(0, 0);

    // TOP-LEFT easeInOut CURVE: 
    // Control Point 1 pulls exactly 50% right along the top edge
    // Control Point 2 pulls exactly 50% left along the bar edge
    ctx.bezierCurveTo(cw * 0.5, 0,   cw * 0.5, barTop,   cw, barTop);

    // Straight line across the top of the bar
    ctx.lineTo(w - cw, barTop);

    // TOP-RIGHT easeInOut CURVE:
    ctx.bezierCurveTo(w - (cw * 0.5), barTop,   w - (cw * 0.5), 0,   w, 0);

    // Straight line down the right module wall
    ctx.lineTo(w, h);

    // BOTTOM-RIGHT easeInOut CURVE: Starts at absolute bottom of bounding box (w, h)
    ctx.bezierCurveTo(w - (cw * 0.5), h,   w - (cw * 0.5), barBottom,   w - cw, barBottom);

    // Straight line across the bottom of the bar
    ctx.lineTo(cw, barBottom);

    // BOTTOM-LEFT easeInOut CURVE:
    ctx.bezierCurveTo(cw * 0.5, barBottom,   cw * 0.5, h,   0, h);

    ctx.closePath();
    ctx.fill();
  }
}
