#import "Rik.h"

@implementation Rik(RikFocusFrame)

- (void) drawFocusFrame: (NSRect) frame view: (NSView*) view
{
  NSLog(@"%@", [view className]);
  NSBezierPath * path;
  if([view class] == [NSButton class])
    {
        int bezel_style = [(NSButton*)view bezelStyle];
        path = [self buttonBezierPathWithRect: NSInsetRect([view bounds], 1, 1)
                                     andStyle: bezel_style];
    }
  else if([view class] == [NSStepper class])
    {
      path = [self stepperBezierPathWithFrame: frame];
    }
  else if([view class] == [NSMatrix class])
    {
      return;
    }
  else
    {
      path = [NSBezierPath bezierPathWithRect: frame];
    }
  NSColor * c = [NSColor selectedControlColor];
  [c setStroke];
  [path setLineWidth: 2];
  [path stroke];
}

- (NSSize) sizeForBorderType: (NSBorderType)aType
{
      switch (aType)
	{
	  case NSLineBorder:
	    return NSMakeSize(4, 4);
	  case NSGrooveBorder:
	  case NSBezelBorder:
	    return NSMakeSize(4, 4);
	  case NSNoBorder:
	  default:
	    return NSZeroSize;
	}
}

@end
