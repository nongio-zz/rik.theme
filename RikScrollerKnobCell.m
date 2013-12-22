#include <AppKit/AppKit.h>
#include "RikScrollerKnobCell.h"

@implementation RikScrollerKnobCell


@synthesize horizontal;

- (void) drawWithFrame: (NSRect)cellFrame inView: (NSView*)controlView
{
  if (NSIsEmptyRect(cellFrame))
    return;

  NSColor * baseColor = [NSColor colorWithCalibratedRed: 0.6
                                                  green: 0.6
                                                   blue:0.6
                                                  alpha: 1.0];
  cellFrame = NSInsetRect(cellFrame, 1, 1);
  CGFloat radius = 4;
  NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: cellFrame
                                                                       xRadius: radius
                                                                       yRadius: radius];
  [baseColor setFill];
  [roundedRectanglePath fill];
  
}
@end
