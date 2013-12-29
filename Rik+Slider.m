#import "Rik.h"

@interface GSTheme()

- (void) drawCircularBezel: (NSRect)cellFrame
                 withColor: (NSColor*)backgroundColor;
@end

@implementation Rik (RikSlider)
- (void) drawSliderBorderAndBackground: (NSBorderType)aType
				 frame: (NSRect)cellFrame
				inCell: (NSCell *)cell
			  isHorizontal: (BOOL)horizontal
{
}

- (void) drawBarInside: (NSRect)rect
		inCell: (NSCell *)cell
	       flipped: (BOOL)flipped
{
  NSSliderType type = [(NSSliderCell *)cell sliderType];
  if (type == NSLinearSlider)
    {
      BOOL horizontal = (rect.size.width > rect.size.height);

      //// Color Declarations
      NSColor* strokeBaseColor = [NSColor colorWithCalibratedRed: 0.733 green: 0.733 blue: 0.733 alpha: 1];
      NSColor* strokeLight = [strokeBaseColor shadowWithLevel: 0.2];
      NSColor* strokeDark = [strokeBaseColor shadowWithLevel: 0.5];
      NSColor* strokeDark2 = [strokeBaseColor shadowWithLevel: 0.4];
      NSColor* strokeLight2 = [strokeBaseColor highlightWithLevel: 0.1];

      //// Gradient Declarations
      NSGradient* strokeGradient = [[NSGradient alloc] initWithStartingColor: strokeDark endingColor: strokeLight];
      NSGradient* fillGradient = [[NSGradient alloc] initWithColorsAndLocations:
          strokeDark2, 0.0,
          strokeLight2, 1.0, nil];
      int w,h,a,x,y;
      if(horizontal)
      {
        w = NSWidth(rect) - 4;
        h = 6;
        a = 90;
        x = NSMinX(rect) + 2;
        y = NSMinY(rect) + NSHeight(rect)/2 - h/2;
      }
      else
      {
        w = 6;
        h = NSHeight(rect) - 4;
        a = 0;
        x = NSMinX(rect) + NSWidth(rect)/2 - floor(w * 0.5 - 0.5) ;
        y = NSMinY(rect);
      }
      rect.size.height = 8;
      NSRect r = NSMakeRect(x, y, w, h);
      NSRect r2 = NSMakeRect(x+1, y+1, w-2, h-2 );
      //// border Drawing
      NSBezierPath* borderPath = [NSBezierPath bezierPathWithRoundedRect:r  xRadius: 3 yRadius: 3];
      [strokeGradient drawInBezierPath: borderPath angle: a];


      //// fill Drawing
      NSBezierPath* fillPath = [NSBezierPath bezierPathWithRoundedRect:r2  xRadius: 3 yRadius: 3];
      [fillGradient drawInBezierPath: fillPath angle: a];
    }
}

- (void) drawKnobInCell: (NSCell *)cell
{
  NSView *controlView = [cell controlView];
  NSSliderCell *sliderCell = (NSSliderCell *)cell;
  NSRect r = 	[sliderCell knobRectFlipped: [controlView isFlipped]];
  r.size.height += 2;
  r.size.width += 2;
  r.origin.x -= 1;
  r.origin.y -= 1;
  NSColor	*color = [NSColor colorWithCalibratedRed: 0.9
                                             green: 0.9
                                              blue: 0.9
                                             alpha: 1];
  [self drawCircularBezel:r  withColor: color];
}
@end
