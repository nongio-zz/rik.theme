#include <AppKit/AppKit.h>
#include "RikWindowButtonCell.h"

@implementation RikWindowButtonCell

@synthesize baseColor;


- (void) drawBallWithRect: (NSRect)frame{
  frame = NSInsetRect(frame, 0.5, 0.5);
  NSColor * bc = baseColor;
  float luminosity = 0.5;
  if(_cell.is_highlighted)
    {
      bc = [baseColor shadowWithLevel: 0.2];
      luminosity = 0.3;
    }
  NSColor* gradientDownColor1 = [bc highlightWithLevel: luminosity];
  NSColor* gradientDownColor2 = [bc colorWithAlphaComponent: 0];
  NSColor* shadowColor1 = [bc shadowWithLevel: 0.5];
  NSColor* shadowColor2 = [bc shadowWithLevel: 0.8];
  NSColor* gradientStrokeColor2 = [shadowColor1 highlightWithLevel: luminosity];
  NSColor* gradientUpColor1 = [bc highlightWithLevel: luminosity+0.2];
  NSColor* gradientUpColor2 = [gradientUpColor1 colorWithAlphaComponent: 0.5];
  NSColor* gradientUpColor3 = [gradientUpColor1 colorWithAlphaComponent: 0];
  NSColor* light1 = [NSColor whiteColor];
  NSColor* light2 = [light1 colorWithAlphaComponent:0];

  //// Gradient Declarations
  NSGradient* gradientUp = [[NSGradient alloc] initWithColorsAndLocations:
      gradientUpColor1, 0.1,
      gradientUpColor2, 0.3,
      gradientUpColor3, 1.0, nil];
  NSGradient* gradientDown = [[NSGradient alloc] initWithColorsAndLocations:
      gradientDownColor1, 0.0,
      gradientDownColor2, 1.0, nil];
  NSGradient* baseGradient = [[NSGradient alloc] initWithColorsAndLocations:
      bc, 0.0,
      shadowColor1, 0.80, nil];
  NSGradient* gradientStroke = [[NSGradient alloc] initWithColorsAndLocations:
      light1, 0.2,
      light2, 1.0, nil];
  NSGradient* gradientStroke2 = [[NSGradient alloc] initWithColorsAndLocations:
      shadowColor2, 0.47,
      gradientStrokeColor2, 1.0, nil];

//paintcode stuff...
  NSRect baseCircleGradientStrokeRect = frame;
  NSRect baseCircleGradientStrokeRect2 = NSInsetRect(baseCircleGradientStrokeRect, 0.5, 0.5);
  frame =  NSInsetRect(frame, 1, 1);

  NSRect baseCircleRect = NSMakeRect(NSMinX(frame) + floor(NSWidth(frame) * 0.06667 + 0.5), NSMinY(frame) + floor(NSHeight(frame) * 0.06667 + 0.5), floor(NSWidth(frame) * 0.93333 + 0.5) - floor(NSWidth(frame) * 0.06667 + 0.5), floor(NSHeight(frame) * 0.93333 + 0.5) - floor(NSHeight(frame) * 0.06667 + 0.5));
  NSRect basecircle2Rect = NSMakeRect(NSMinX(frame) + floor(NSWidth(frame) * 0.06667 + 0.5), NSMinY(frame) + floor(NSHeight(frame) * 0.06667 + 0.5), floor(NSWidth(frame) * 0.93333 + 0.5) - floor(NSWidth(frame) * 0.06667 + 0.5), floor(NSHeight(frame) * 0.93333 + 0.5) - floor(NSHeight(frame) * 0.06667 + 0.5));

  //// BaseCircleGradientStroke Drawing
  NSBezierPath* baseCircleGradientStrokePath = [NSBezierPath bezierPathWithOvalInRect: baseCircleGradientStrokeRect];
  [gradientStroke drawInBezierPath: baseCircleGradientStrokePath angle: 90];
  NSBezierPath* baseCircleGradientStrokePath2 = [NSBezierPath bezierPathWithOvalInRect: baseCircleGradientStrokeRect2];
  [gradientStroke2 drawInBezierPath: baseCircleGradientStrokePath2 angle: -90];


  //// BaseCircle Drawing
  NSBezierPath* baseCirclePath = [NSBezierPath bezierPathWithOvalInRect: baseCircleRect];
  CGFloat baseCircleResizeRatio = MIN(NSWidth(baseCircleRect) / 13, NSHeight(baseCircleRect) / 13);
  [NSGraphicsContext saveGraphicsState];
  [baseCirclePath addClip];
  [baseGradient drawFromCenter: NSMakePoint(NSMidX(baseCircleRect) + 0 * baseCircleResizeRatio, NSMidY(baseCircleRect) + 0 * baseCircleResizeRatio) radius: 2.85 * baseCircleResizeRatio
      toCenter: NSMakePoint(NSMidX(baseCircleRect) + 0 * baseCircleResizeRatio, NSMidY(baseCircleRect) + 0 * baseCircleResizeRatio) radius: 7.32 * baseCircleResizeRatio
      options: NSGradientDrawsBeforeStartingLocation | NSGradientDrawsAfterEndingLocation];
  [NSGraphicsContext restoreGraphicsState];


  //// basecircle2 Drawing
  NSBezierPath* basecircle2Path = [NSBezierPath bezierPathWithOvalInRect: basecircle2Rect];
  CGFloat basecircle2ResizeRatio = MIN(NSWidth(basecircle2Rect) / 13, NSHeight(basecircle2Rect) / 13);
  [NSGraphicsContext saveGraphicsState];
  [basecircle2Path addClip];
  [gradientDown drawFromCenter: NSMakePoint(NSMidX(basecircle2Rect) + -0.98 * basecircle2ResizeRatio, NSMidY(basecircle2Rect) + -6.5 * basecircle2ResizeRatio) radius: 1.54 * basecircle2ResizeRatio
      toCenter: NSMakePoint(NSMidX(basecircle2Rect) + -1.86 * basecircle2ResizeRatio, NSMidY(basecircle2Rect) + -8.73 * basecircle2ResizeRatio) radius: 8.65 * basecircle2ResizeRatio
      options: NSGradientDrawsBeforeStartingLocation | NSGradientDrawsAfterEndingLocation];
  [NSGraphicsContext restoreGraphicsState];

  //// halfcircle Drawing
  NSBezierPath* halfcirclePath = [NSBezierPath bezierPath];
  [halfcirclePath moveToPoint: NSMakePoint(NSMinX(frame) + 0.93316 * NSWidth(frame), NSMinY(frame) + 0.46157 * NSHeight(frame))];
  [halfcirclePath curveToPoint: NSMakePoint(NSMinX(frame) + 0.78652 * NSWidth(frame), NSMinY(frame) + 0.81548 * NSHeight(frame)) controlPoint1: NSMakePoint(NSMinX(frame) + 0.93316 * NSWidth(frame), NSMinY(frame) + 0.46157 * NSHeight(frame)) controlPoint2: NSMakePoint(NSMinX(frame) + 0.94476 * NSWidth(frame), NSMinY(frame) + 0.66376 * NSHeight(frame))];
  [halfcirclePath curveToPoint: NSMakePoint(NSMinX(frame) + 0.21348 * NSWidth(frame), NSMinY(frame) + 0.81548 * NSHeight(frame)) controlPoint1: NSMakePoint(NSMinX(frame) + 0.62828 * NSWidth(frame), NSMinY(frame) + 0.96721 * NSHeight(frame)) controlPoint2: NSMakePoint(NSMinX(frame) + 0.37172 * NSWidth(frame), NSMinY(frame) + 0.96721 * NSHeight(frame))];
  [halfcirclePath curveToPoint: NSMakePoint(NSMinX(frame) + 0.06684 * NSWidth(frame), NSMinY(frame) + 0.46157 * NSHeight(frame)) controlPoint1: NSMakePoint(NSMinX(frame) + 0.05524 * NSWidth(frame), NSMinY(frame) + 0.66376 * NSHeight(frame)) controlPoint2: NSMakePoint(NSMinX(frame) + 0.06684 * NSWidth(frame), NSMinY(frame) + 0.46157 * NSHeight(frame))];
  [halfcirclePath lineToPoint: NSMakePoint(NSMinX(frame) + 0.93316 * NSWidth(frame), NSMinY(frame) + 0.46157 * NSHeight(frame))];
  [halfcirclePath closePath];
  [halfcirclePath setLineCapStyle: NSRoundLineCapStyle];
  [halfcirclePath setLineJoinStyle: NSRoundLineJoinStyle];
  [gradientUp drawInBezierPath: halfcirclePath angle: -90];
}
- (void) drawWithFrame: (NSRect)cellFrame inView: (NSView*)controlView
{
  if (NSIsEmptyRect(cellFrame))
    return;
  if(baseColor != nil)
    [self drawBallWithRect: cellFrame];
  [self drawInteriorWithFrame: cellFrame inView: controlView];
}
@end
