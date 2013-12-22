#import "Rik.h"
#import "Rik+Drawings.h"

@interface Rik(RikTable)

@end

@implementation Rik(RikTable)


typedef enum {
  GSTabSelectedLeft,
  GSTabSelectedRight,
  GSTabSelectedToUnSelectedJunction,
  GSTabSelectedFill,
  GSTabUnSelectedLeft,
  GSTabUnSelectedRight,
  GSTabUnSelectedToSelectedJunction,
  GSTabUnSelectedJunction,
  GSTabUnSelectedFill,
  GSTabBackgroundFill
} GSTabPart;

- (void) frameTabRectTopAndBottom: (NSRect)aRect 
			 topColor: (NSColor *)topColor
		      bottomColor: (NSColor *)bottomColor
{
  NSLog(@"frameTabRect");
  NSRect bottom = aRect;
  NSRect top = aRect;

  top.size.height = 1;
  bottom.origin.y = NSMaxY(aRect) - 1;
  bottom.size.height = 1;

  [topColor set];
  //NSRectFill(top);

  [bottomColor set];
  //NSRectFill(bottom);
}
- (void) drawTabFillInRect: (NSRect)aRect forPart: (GSTabPart)part type: (NSTabViewType)type
{

    {
      if (type == NSBottomTabsBezelBorder)
	{
	  switch (part)
	    {
	    case GSTabSelectedFill:
	      [self frameTabRectTopAndBottom: aRect
				    topColor: [NSColor clearColor]
				 bottomColor: [NSColor whiteColor]];
	      break;
	    case GSTabUnSelectedFill:
	      [self frameTabRectTopAndBottom: aRect 
				    topColor: [NSColor darkGrayColor] 
				 bottomColor: [NSColor whiteColor]];
	      break;
	    case GSTabBackgroundFill:
	      {
		const NSRect clip = aRect;
		aRect.origin.x -= 2;
		aRect.origin.y = NSMinY(aRect) - 2;
		aRect.size.width += 2;
		aRect.size.height = 4;
		//[self drawButton: aRect withClip: clip];
		break;
	      }
	    default:
	      break;
	    }
	}
      else if (type == NSTopTabsBezelBorder)
	{
	  switch (part)
	    {
	    case GSTabSelectedFill:
	      [self frameTabRectTopAndBottom: aRect
				    topColor: [NSColor whiteColor]
				 bottomColor: [NSColor clearColor]];
	      break;
	    case GSTabUnSelectedFill:
	      [self frameTabRectTopAndBottom: aRect
				    topColor: [NSColor whiteColor]
				 bottomColor: [NSColor whiteColor]];
	      break;
	    case GSTabBackgroundFill:
	      {
		const NSRect clip = aRect;
		aRect.origin.x -= 2;
		aRect.origin.y = NSMaxY(aRect) - 1;
		aRect.size.width += 2;
		aRect.size.height = 4;
		//[self drawButton: aRect withClip: clip];
		break;
	      }
	    default:
	      break;
	    }
	}
    }
}

- (CGFloat) tabHeightForType: (NSTabViewType)type
{
    return 5;
}
- (NSRect) tabViewBackgroundRectForBounds: (NSRect)aRect
			      tabViewType: (NSTabViewType)type
{
  const CGFloat tabHeight = [self tabHeightForType: type];

  switch (type)
    {
      default:
      case NSTopTabsBezelBorder: 
        aRect.size.height -= tabHeight;
        aRect.origin.y += tabHeight;
        break;

      case NSBottomTabsBezelBorder: 
        aRect.size.height -= tabHeight;
        break;

      case NSLeftTabsBezelBorder: 
        aRect.size.width -= tabHeight;
        aRect.origin.x += tabHeight;
        break;

      case NSRightTabsBezelBorder: 
        aRect.size.width -= tabHeight;
        break;

      case NSNoTabsBezelBorder: 
      case NSNoTabsLineBorder: 
      case NSNoTabsNoBorder: 
        break;
    }

  return aRect;
}

- (NSRect) tabViewContentRectForBounds: (NSRect)aRect
			   tabViewType: (NSTabViewType)type
			       tabView: (NSTabView *)view
{
  NSRect cRect = [self tabViewBackgroundRectForBounds: aRect
						   tabViewType: type];
/*
  NSString *name = GSStringFromTabViewType(type);
  GSDrawTiles *tiles = [self tilesNamed: name state: GSThemeNormalState];

  if (tiles == nil)
    {
      switch (type)
	{
	case NSBottomTabsBezelBorder:
	  cRect.origin.x += 1;
	  cRect.origin.y += 1;
	  cRect.size.width -= 3;
	  cRect.size.height -= 2;
	  break;
	case NSNoTabsBezelBorder:
	  cRect.origin.x += 1;
	  cRect.origin.y += 1;
	  cRect.size.width -= 3;
	  cRect.size.height -= 2;
	  break;
	case NSNoTabsLineBorder:
	  cRect.origin.y += 1; 
	  cRect.origin.x += 1; 
	  cRect.size.width -= 2;
	  cRect.size.height -= 2;
	  break;
	case NSTopTabsBezelBorder:
	  cRect.origin.x += 1;
	  cRect.origin.y += 1;
	  cRect.size.width -= 3;
	  cRect.size.height -= 2;
	  break;
	case NSLeftTabsBezelBorder:
	  cRect.origin.x += 1;
	  cRect.origin.y += 1;
	  cRect.size.width -= 3;
	  cRect.size.height -= 2;
	  break;
	case NSRightTabsBezelBorder:
	  cRect.origin.x += 1;
	  cRect.origin.y += 1;
	  cRect.size.width -= 3;
	  cRect.size.height -= 2;
	  break;
	case NSNoTabsNoBorder:
	default:
	  break;
	}     
    }
  else
    {
      cRect = [tiles contentRectForRect: cRect
			      isFlipped: [view isFlipped]];
    }
*/
  return cRect;
}
- (void) drawTabViewRect: (NSRect)rect
		  inView: (NSView *)view
	       withItems: (NSArray *)items
	    selectedItem: (NSTabViewItem *)selected
{
  //// Color Declarations
/*
  NSColor* white = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 1];
  NSColor* buttonStroke = [NSColor colorWithCalibratedRed: 0.557 green: 0.557 blue: 0.557 alpha: 1];
  NSColor* black = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
  NSColor* clear = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
  NSColor* buttonNormal1 = [NSColor colorWithCalibratedRed: 0.953 green: 0.953 blue: 0.953 alpha: 1];

  //// Gradient Declarations
  NSGradient* normalButtongradient = [[NSGradient alloc] initWithColorsAndLocations:
      white, 0.52,
      buttonNormal1, 0.53, nil];

  const NSUInteger howMany = [items count];
  int i;
  int previousState = 0;
  const NSTabViewType type = [(NSTabView *)view tabViewType];
  const NSRect bounds = [view bounds];
  NSRect aRect = [self tabViewBackgroundRectForBounds: bounds tabViewType: type];

  const BOOL truncate = [(NSTabView *)view allowsTruncatedLabels];
  const CGFloat tabHeight = [self tabHeightForType: type];

  [self drawTabViewBezelRect: aRect
 		 tabViewType: type
 		      inView: view];
  if (type == NSBottomTabsBezelBorder
      || type == NSTopTabsBezelBorder)
    {
      NSPoint iP;
      if (type == NSTopTabsBezelBorder)
	iP = bounds.origin;
  NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
  
  if ([defs objectForKey: @"GSBrowserColumnSeparation"] != nil)
    {
      return [defs floatForKey: @"GSBrowserColumnSeparation"];
    }
  else
    {
      else
	iP = NSMakePoint(aRect.origin.x, NSMaxY(aRect));

    for (i = 0; i < howMany; i++)
      {
        NSRect frame = NSMakeRect(iP.x, iP.y, 100, 30);
        //// button2 Drawing
        CGFloat button2CornerRadius = 4;
        NSRect button2Rect = NSMakeRect(NSMinX(frame) + 50.5, NSMinY(frame) + NSHeight(frame) - 20.5, 45, 17);
        NSRect button2InnerRect = NSInsetRect(button2Rect, button2CornerRadius, button2CornerRadius);
        NSBezierPath* button2Path = [NSBezierPath bezierPath];
        [button2Path moveToPoint: NSMakePoint(NSMinX(button2Rect), NSMinY(button2Rect))];
        [button2Path appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(button2InnerRect), NSMinY(button2InnerRect)) radius: button2CornerRadius startAngle: 270 endAngle: 360];
        [button2Path appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(button2InnerRect), NSMaxY(button2InnerRect)) radius: button2CornerRadius startAngle: 0 endAngle: 90];
        [button2Path lineToPoint: NSMakePoint(NSMinX(button2Rect), NSMaxY(button2Rect))];
        [button2Path closePath];
        [normalButtongradient drawInBezierPath: button2Path angle: -90];
        iP.x += frame.size.width;
      }
  }
*/
}
@end
