
#include <AppKit/AppKit.h>
#include "RikScrollerKnobSlotCell.h"

@implementation RikScrollerKnobSlotCell


@synthesize horizontal;

- (void) drawWithFrame: (NSRect)cellFrame inView: (NSView*)controlView
{
  if (NSIsEmptyRect(cellFrame))
    return;
//  [self drawBallWithRect: cellFrame];

  NSColor * baseColor = [NSColor whiteColor];
//  if([self backgroundColor])
//    baseColor = [self backgroundColor];
  NSColor *shadowColor = [baseColor shadowWithLevel: 0.05];
  NSGradient* gr = [[NSGradient alloc] initWithColorsAndLocations:
      shadowColor, 1.0,
      baseColor, 0.7,
      baseColor, 0.5,
      baseColor, 0.3,
      shadowColor, 0.0,
      nil];
  int a = 0;
  if(horizontal)
    a = 90;
  [gr drawInRect: cellFrame angle: a];
  //[self drawInteriorWithFrame: cellFrame inView: controlView];
}
@end
