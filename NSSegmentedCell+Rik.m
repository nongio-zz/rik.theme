#include "Rik.h"

@interface NSSegmentedCell(RikTheme)
@end
@implementation NSSegmentedCell(RikTheme)


- (NSColor*) textColor
{
  //IT DOES NOT WORKS
  if(_cell.state == GSThemeSelectedState)
    return [NSColor whiteColor];
  if (_cell.is_disabled)
    return [NSColor disabledControlTextColor];
  else
    return [NSColor controlTextColor];
}
- (void) _drawBorderAndBackgroundWithFrame: (NSRect)cellFrame
                                    inView: (NSView*)controlView
{
  CGFloat radius = 4;
  cellFrame = NSInsetRect(cellFrame, 0.5, 0.5);
  NSColor* strokeColorButton = [Rik controlStrokeColor];
  NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: cellFrame
                                                                       xRadius: radius
                                                                       yRadius: radius];
  [strokeColorButton setStroke];
  [roundedRectanglePath setLineWidth: 1];
  [roundedRectanglePath stroke];
  NSInteger i;
  NSUInteger count = [_items count];
  NSRect frame = cellFrame;
  NSRect controlFrame = [controlView frame];

  NSBezierPath* linesPath = [NSBezierPath bezierPath];
  [linesPath setLineWidth: 1];
  CGFloat offsetX = 0;
  for (i = 0; i < count-1;i++)
    {
      frame.size.width = [[_items objectAtIndex: i] width];
      if(frame.size.width == 0.0)
        {
          frame.size.width = (controlFrame.size.width - frame.origin.x) / (count);
        }
      offsetX += frame.size.width;
      offsetX = floor(offsetX) + 0.5;
      [linesPath moveToPoint: NSMakePoint(offsetX, NSMinY(frame))];
      [linesPath lineToPoint: NSMakePoint(offsetX, NSMaxY(frame))];
    }
  [linesPath stroke];
}
- (void) drawWithFrame: (NSRect)cellFrame inView: (NSView*)controlView
{
  if (NSIsEmptyRect(cellFrame))
    return;
// i want to draw the border for last
  [self drawInteriorWithFrame: cellFrame inView: controlView];
  [self _drawBorderAndBackgroundWithFrame: cellFrame inView: controlView];
  //[self _drawFocusRingWithFrame: cellFrame inView: controlView];
}
@end
