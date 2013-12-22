#import "Rik.h"
#import "Rik+Drawings.h"

@interface Rik(RikBrowser)

@end

@implementation Rik(RikBrowser)
- (NSColor *) browserHeaderTextColor
{
  return [NSColor blackColor];
}

- (void) drawBrowserHeaderCell: (NSTableHeaderCell*)cell
	 	     withFrame: (NSRect)rect
			inView: (NSView*)view;
{
  NSColor* bc = [NSColor colorWithCalibratedRed: 0.9 green: 0.9 blue: 0.9 alpha: 1];
  NSGradient * g = [self _buttonGradientWithColor: bc];
  [g drawInRect: rect angle: 90];
  NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0.7
                                                   green: 0.7
                                                    blue: 0.7
                                                   alpha: 1];
  [strokeColor set];
  NSFrameRect(rect);
  NSBezierPath* linePath = [NSBezierPath bezierPath];
  [linePath moveToPoint: NSMakePoint(NSMinX(rect), NSMinY(rect)+0.5)];
  [linePath lineToPoint: NSMakePoint(NSMaxX(rect), NSMinY(rect)+0.5)];
  [linePath stroke];
}
- (NSRect) browserHeaderDrawingRectForCell: (NSTableHeaderCell*)cell
				 withFrame: (NSRect)rect
{
  return NSInsetRect(rect, 4, 4);
}
- (void) drawBrowserRect: (NSRect)rect
		  inView: (NSView *)view
	withScrollerRect: (NSRect)scrollerRect
	      columnSize: (NSSize)columnSize
{
  NSBrowser *browser = (NSBrowser *)view;
  NSRect bounds = [view bounds];

  // Load the first column if not already done
  if (![browser isLoaded])
    {
      [browser loadColumnZero];
    }

  // Draws titles
  if ([browser isTitled])
    {
      int i;

      for (i = [browser firstVisibleColumn];
	   i <= [browser lastVisibleColumn];
	   ++i)
        {
          NSRect titleRect = [browser titleFrameOfColumn: i];
          if (NSIntersectsRect (titleRect, rect) == YES)
            {
              [browser drawTitleOfColumn: i
                    inRect: titleRect];
            }
        }
    }
}

- (CGFloat) browserColumnSeparation
{
  return 0;
}

- (CGFloat) browserVerticalPadding
{
  return 0;
}

- (BOOL) browserUseBezels
{
  return NO;
}
@end
