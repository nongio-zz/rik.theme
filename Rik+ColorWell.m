#import "Rik.h"

@interface Rik(RikColorWell)

@end

@implementation Rik(RikColorWell)
- (NSRect) drawColorWellBorder: (NSColorWell*)well
                    withBounds: (NSRect)bounds
                      withClip: (NSRect)clipRect
{
  NSRect aRect = bounds;
  NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0.624
                                                  green: 0.624
                                                    blue: 0.624
                                                  alpha: 1];
  if ([well isBordered])
    {
      GSThemeControlState state;

      if ([[well cell] isHighlighted] || [well isActive])
        {
          state = GSThemeHighlightedState;
        }
      else
        {
          state = GSThemeNormalState;
        }

	  /*
	   * Draw border.
	   */
	  //[self drawButton: aRect withClip: clipRect];

	  /*
	   * Fill in control color.
	   */
      NSGradient * fill;
	    NSColor * baseColor = [[NSColor controlColor] shadowWithLevel: 0.1];
      NSColor* white = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 1];
      if (state == GSThemeHighlightedState)
	    {
        NSColor* shadow = [baseColor shadowWithLevel: 0.5];
        fill  = [[NSGradient alloc] initWithColorsAndLocations:
              white, 0.0,
              shadow, 0.20,
              shadow, 0.23,
              baseColor, 1.0,
              nil];
	    }
	  else
	    {
        fill  = [[NSGradient alloc] initWithColorsAndLocations:
          white, 0.1,
          baseColor, 0.18, nil];
	    }
//	  aRect = NSInsetRect(aRect, 2.0, 2.0);
	  //NSRectFill(NSIntersectionRect(aRect, clipRect));
    [fill drawInRect: NSIntersectionRect(aRect, clipRect) angle: -90];
      /*
       * Set an inset rect for the color area
       */
      aRect = NSInsetRect(bounds, 6, 6);
    }

    [strokeColor set];
    NSFrameRect(bounds);
    [strokeColor set];
    NSFrameRectWithWidth(aRect, 1);
  if ([well isEnabled])
    {
      aRect = NSInsetRect(aRect, 1.0, 1.0);
    }
  return aRect;
}
@end
