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
		part.origin.x +=1;
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
	CGFloat radius = cellFrame.size.height / 2.0;
	NSRect rect = cellFrame;
	rect.origin.x -= 0.5;
	rect.origin.y += 0.5;
	rect.size.height -= 1;
	//rect.size.width += 1;
	NSBezierPath* roundedSearchFieldPath = [NSBezierPath bezierPathWithRoundedRect: rect
                                                                       xRadius: radius
                                                                       yRadius: radius];
	[roundedSearchFieldPath setLineWidth:1.0];
	[[NSColor whiteColor] setFill];
	[roundedSearchFieldPath fill];
	[[Rik controlStrokeColor] setStroke];
	[roundedSearchFieldPath stroke];
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
          frame.origin.x += 15;
          frame.size.width -= 30;
          frame.origin.y -= 1;
          frame.size.height += 1;
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
  search.origin.x +=2;
  return search;
}


- (NSRect) cancelButtonRectForBounds: (NSRect)rect
{
  NSRect part, clear;

  NSDivideRect(rect, &clear, &part, ICON_WIDTH, NSMaxXEdge);
  clear.origin.x -= 2; //This set the position inside the textsearch box
  return clear;
}

@end
