#include "Rik.h"
#include "RikScrollerKnobSlotCell.h"

@interface Rik(RikScroller)

@end

@implementation Rik(RikScroller)

/* NSScroller themeing. */

- (NSButtonCell*) cellForScrollerArrow: (NSScrollerArrow)arrow
			    horizontal: (BOOL)horizontal
{
  NSButtonCell	*cell;
  NSString	*name;

  cell = [NSButtonCell new];
  [cell setBezelStyle: NSRegularSquareBezelStyle];
  if (horizontal)
    {
      if (arrow == NSScrollerDecrementArrow)
	{
	  [cell setHighlightsBy:
	    NSChangeBackgroundCellMask | NSContentsCellMask];
	  [cell setImage: [NSImage imageNamed: @"common_ArrowLeft"]];
	  [cell setAlternateImage: [NSImage imageNamed: @"common_ArrowLeftH"]];
	  [cell setImagePosition: NSImageOnly];
          name = GSScrollerLeftArrow;
	}
      else
	{
	  [cell setHighlightsBy:
	    NSChangeBackgroundCellMask | NSContentsCellMask];
	  [cell setImage: [NSImage imageNamed: @"common_ArrowRight"]];
	  [cell setAlternateImage: [NSImage imageNamed: @"common_ArrowRightH"]];
	  [cell setImagePosition: NSImageOnly];
          name = GSScrollerRightArrow;
	}
    }
  else
    {
      if (arrow == NSScrollerDecrementArrow)
	{
	  [cell setHighlightsBy:
	    NSChangeBackgroundCellMask | NSContentsCellMask];
	  [cell setImage: [NSImage imageNamed: @"common_ArrowUp"]];
	  [cell setAlternateImage: [NSImage imageNamed: @"common_ArrowUpH"]];
	  [cell setImagePosition: NSImageOnly];
          name = GSScrollerUpArrow;
	}
      else
	{
	  [cell setHighlightsBy:
	    NSChangeBackgroundCellMask | NSContentsCellMask];
	  [cell setImage: [NSImage imageNamed: @"common_ArrowDown"]];
	  [cell setAlternateImage: [NSImage imageNamed: @"common_ArrowDownH"]];
	  [cell setImagePosition: NSImageOnly];
          name = GSScrollerDownArrow;
	}
    }
  [self setName: name forElement: cell temporary: YES];
  RELEASE(cell);
  return cell;
}

- (NSCell*) cellForScrollerKnob: (BOOL)horizontal
{
  NSButtonCell	*cell;

  cell = [NSButtonCell new];
  [cell setButtonType: NSMomentaryChangeButton];
  [cell setBezelStyle: NSRoundedBezelStyle];
	  [cell setImagePosition: NSImageOnly];

  NSColor* bc = [NSColor colorWithCalibratedRed: 0.4
                                                         green: 0.4
                                                          blue: 0.4
                                                         alpha: 1];
  [cell setTitle: @""];
  if (horizontal)
    {
      [self setName: GSScrollerHorizontalKnob forElement: cell temporary: YES];
    }
  else
    {
      [self setName: GSScrollerVerticalKnob forElement: cell temporary: YES];
    }
  RELEASE(cell);
  return cell;
}

- (NSCell*) cellForScrollerKnobSlot: (BOOL)horizontal
{
  GSDrawTiles   *tiles;
  NSButtonCell	*cell;
  NSColor	*color;
  NSString      *name;

  if (horizontal)
    {
      name = GSScrollerHorizontalSlot;
    }
  else
    {
      name = GSScrollerVerticalSlot;
    }

  tiles = [self tilesNamed: name state: GSThemeNormalState];
  color = [self colorNamed: name state: GSThemeNormalState];

  cell = [RikScrollerKnobSlotCell new];
  [cell setBordered: false];
  [cell setTitle: nil];
  [cell setHorizontal: horizontal];
  [self setName: name forElement: cell temporary: YES];

  if (color == nil)
    {
      color = [NSColor scrollBarColor];
    }
  [cell setBackgroundColor: color];
  RELEASE(cell);
  return cell;
}
// REMEMBER THIS SETTING
- (float) defaultScrollerWidth
{
  NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
  float defaultScrollerWidth;

  if ([defs objectForKey: @"GSScrollerDefaultWidth"] != nil)
    {
      defaultScrollerWidth = [defs floatForKey: @"GSScrollerDefaultWidth"];
    }
  else
    {
      defaultScrollerWidth = 12.0;
    }
  return defaultScrollerWidth;
}

- (BOOL) scrollViewUseBottomCorner
{
  NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
  if ([defs objectForKey: @"GSScrollViewUseBottomCorner"] != nil)
    {
      return [defs boolForKey: @"GSScrollViewUseBottomCorner"];
    }
  return YES;
}

- (BOOL) scrollViewScrollersOverlapBorders
{
  NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
  if ([defs objectForKey: @"GSScrollViewScrollersOverlapBorders"] != nil)
    {
      return [defs boolForKey: @"GSScrollViewScrollersOverlapBorders"];
    }
  return NO;
}
//NOT TOUCHED
- (void) drawScrollerRect: (NSRect)rect
		   inView: (NSView *)view
		  hitPart: (NSScrollerPart)hitPart
	     isHorizontal: (BOOL)isHorizontal
{
  NSRect rectForPartIncrementLine;
  NSRect rectForPartDecrementLine;
  NSRect rectForPartKnobSlot;
  NSScroller *scroller = (NSScroller *)view;

  rectForPartIncrementLine = [scroller rectForPart: NSScrollerIncrementLine];
  rectForPartDecrementLine = [scroller rectForPart: NSScrollerDecrementLine];
  rectForPartKnobSlot = [scroller rectForPart: NSScrollerKnobSlot];

  /*
  [[[view window] backgroundColor] set];
  NSRectFill (rect);
  */

  if (NSIntersectsRect (rect, rectForPartKnobSlot) == YES)
    {
      [scroller drawKnobSlot];
      [scroller drawKnob];
    }

  if (NSIntersectsRect (rect, rectForPartDecrementLine) == YES)
    {
      [scroller drawArrow: NSScrollerDecrementArrow 
		highlight: hitPart == NSScrollerDecrementLine];
    }
  if (NSIntersectsRect (rect, rectForPartIncrementLine) == YES)
    {
      [scroller drawArrow: NSScrollerIncrementArrow 
		highlight: hitPart == NSScrollerIncrementLine];
    }
}

- (void) drawKnobInCell: (NSCell *)cell
{
  NSView *controlView = [cell controlView];
  NSSliderCell *sliderCell = (NSSliderCell *)cell;
  NSRect r = 	[sliderCell knobRectFlipped: [controlView isFlipped]];
  r.size.height += 4;
  r.size.width += 4;
  r.origin.x -= 2;
  r.origin.y -= 2;
  NSColor	*color = [NSColor colorWithCalibratedRed: 0.9
                                             green: 0.9
                                              blue: 0.9
                                             alpha: 1];
  [self drawCircularBezel:r  withColor: color];
}
- (void) drawCircularBezel: (NSRect)cellFrame withColor: (NSColor*)backgroundColor
{
  //// Color Declarations
  NSColor* strokeColorButton = [NSColor colorWithCalibratedRed: 0.4
                                                         green: 0.4
                                                          blue: 0.4
                                                         alpha: 1];

  //// Gradient Declarations
  NSGradient* buttonBackgroundGradient = [self _bezelGradientWithColor:
    backgroundColor];

  //// Abstracted Attributes
  CGFloat roundedRectangleStrokeWidth = 1;

  float radius = NSHeight(cellFrame) / 2.0;
  cellFrame = NSInsetRect(cellFrame, 1.0, 1.0);
  float circle_radius = MIN(NSWidth(cellFrame), NSHeight(cellFrame)) / 2;
  cellFrame = NSMakeRect( cellFrame.origin.x + cellFrame.size.width/2.0 - circle_radius,
                          cellFrame.origin.y,
                          circle_radius*2,
                          circle_radius*2);

  NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect: cellFrame
                                                                       xRadius: radius
                                                                       yRadius: radius];
  [buttonBackgroundGradient drawInBezierPath: roundedRectanglePath angle: -90];
  [strokeColorButton setStroke];
  [roundedRectanglePath setLineWidth: roundedRectangleStrokeWidth];
  [roundedRectanglePath stroke];

}
- (NSGradient *) _bezelGradientWithColor:(NSColor*) baseColor
{
  baseColor = [baseColor colorUsingColorSpaceName: NSCalibratedRGBColorSpace];

  NSColor* baseColorLight = [baseColor highlightWithLevel: 0.8];
  NSColor* baseColorLight2 = [baseColor highlightWithLevel: 0.5];
  NSColor* baseColorShadow = [baseColor shadowWithLevel: 0.1];

  NSGradient* gradient = [[NSGradient alloc] initWithColorsAndLocations:
      baseColorLight, 0.0,
      baseColor, 0.30,
      baseColor, 0.49,
      baseColorLight2, 0.50,
      nil];
  return gradient;
}
@end
