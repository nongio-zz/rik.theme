/**
* Copyright (C) 2013 Alessandro Sangiuliano
* Author: Alessandro Sangiuliano <alex22_7@hotmail.com>
* Date: 31 December 2013
*/

#import "Rik.h"
#import "NSSearchFieldCell+Rik.h"
#import "Rik+Button.h"

#define ICON_WIDTH	16


@implementation NSSearchFieldCell (RikTheme)

- (void) drawWithFrame: (NSRect)cellFrame inView: (NSView*)controlView
{
  NSRect frame = cellFrame;
  [super drawWithFrame: [self searchTextRectForBounds: cellFrame ]
	 inView: controlView];
 [_search_button_cell drawWithFrame: [self searchButtonRectForBounds: cellFrame] inView: controlView];
  if ([[self stringValue] length] > 0)
    [_cancel_button_cell drawWithFrame: [self cancelButtonRectForBounds: cellFrame]
		       inView: controlView];
}

/* This method put the "x" cell inside the Text cell */

- (NSRect) searchTextRectForBounds: (NSRect)rect
{
	NSRect search, text, part;

	if (_search_button_cell)
	{
		part = rect;
		/*set the right point and size*/
		part.origin.x +=0;
		part.size.width -= 1;
	}
	else
	{
		NSDivideRect(rect, &search, &part, ICON_WIDTH, NSMinXEdge);
	}

	text = part;

	return text;
}

- (void) _drawBorderAndBackgroundWithFrame: (NSRect)cellFrame
                                    inView: (NSView*)controlView
{

  NSColor* whiteColor = [NSColor colorWithCalibratedRed: 1
                                                  green: 1
                                                   blue: 1
                                                  alpha: 0.8];
  NSColor* clearColor = [NSColor colorWithCalibratedRed: 1
                                                  green: 1
                                                   blue: 1
                                                  alpha: 0];
  NSColor * strokeBaseColor = [Rik controlStrokeColor];
  NSColor * strokeLightColor = [strokeBaseColor highlightWithLevel: 0.3];

  NSGradient* lightGradient = [[NSGradient alloc] initWithColorsAndLocations:
      clearColor, 0.0,
      whiteColor, 0.97, nil];
  NSGradient* bezelBorderGradient = [[NSGradient alloc] initWithColorsAndLocations:
      strokeBaseColor, 1.0,
      strokeLightColor, 0.5, nil];
  NSGradient* fillGradient = [[NSGradient alloc] initWithColorsAndLocations:
      [strokeBaseColor highlightWithLevel: 0.7], 0.0,
      [NSColor whiteColor], 0.2, nil];

	NSRect rect = cellFrame;
	CGFloat radius = rect.size.height / 2.0;
	NSBezierPath* lightPath = [NSBezierPath bezierPathWithRoundedRect: rect
                                                                       xRadius: radius
                                                                       yRadius: radius];

	NSBezierPath* bezelPath = [NSBezierPath bezierPathWithRoundedRect: NSInsetRect(rect, 1, 1)
                                                                       xRadius: radius-2
                                                                       yRadius: radius-2];
	NSBezierPath* fillPath = [NSBezierPath bezierPathWithRoundedRect: NSInsetRect(rect, 2, 2)
                                                                       xRadius: radius-2
                                                                       yRadius: radius-2];
  [lightGradient drawInBezierPath: lightPath angle: 90];
  [bezelBorderGradient drawInBezierPath: bezelPath angle: -90];

  [fillGradient drawInBezierPath: fillPath angle: 90];
}

- (void) drawInteriorWithFrame: (NSRect)cellFrame inView: (NSView*)controlView
{
  if (_cell.in_editing)
   [self _drawEditorWithFrame: cellFrame inView: controlView];
  else
    {
      NSRect titleRect;

      /* Make sure we are a text cell; titleRect might return an incorrect
         rectangle otherwise. Note that the type could be different if the
         user has set an image on us, which we just ignore (OS X does so as
         well). */
      _cell.type = NSTextCellType;
      titleRect = [self titleRectForBounds: cellFrame];
      [[self _drawAttributedString] drawInRect: titleRect];
    }
}

- (void) _drawEditorWithFrame: (NSRect)cellFrame
		       inView: (NSView *)controlView
{
  if ([controlView isKindOfClass: [NSControl class]])
    {
      /* Adjust the text editor's frame to match cell's frame (w/o border) */
      NSRect titleRect = [self titleRectForBounds: cellFrame];
      NSText *textObject = [(NSControl*)controlView currentEditor];
      NSView *clipView = [textObject superview];

      if ([clipView isKindOfClass: [NSClipView class]])
	{
	  [clipView setFrame: titleRect];
	}
      else
	{
	  [textObject setFrame: titleRect];
	}
    }
}

- (NSRect) titleRectForBounds: (NSRect)theRect
{
  if (_cell.type == NSTextCellType)
    {
      NSRect frame = [self drawingRectForBounds: theRect];
       //Add spacing between border and inside
      if (_cell.is_bordered || _cell.is_bezeled)
        {
          frame.origin.x += 16;
          frame.size.width -= 30;
          frame.size.height += 2;
        }
      return frame;
    }
  else
    {
      return theRect;
    }
}

- (NSRect) searchButtonRectForBounds: (NSRect)rect;
{
  NSRect search, part;
  NSDivideRect(rect, &search, &part, ICON_WIDTH, NSMinXEdge);
  search.origin.x += 4;
  search.origin.y += 0;
  return search;
}


- (NSRect) cancelButtonRectForBounds: (NSRect)rect
{
  NSRect part, clear;

  NSDivideRect(rect, &clear, &part, ICON_WIDTH, NSMaxXEdge);
  clear.origin.x -= 5; //This set the position inside the textsearch box
  return clear;
}

@end
