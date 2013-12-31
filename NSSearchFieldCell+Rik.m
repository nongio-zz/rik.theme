/**
* Copyright (C) 2013 Alessandro Sangiuliano
* Author: Alessandro Sangiuliano <alex22_7@hotmail.com>
* Date: 31 December 2013
*/

#import "Rik.h"
#import "NSSearchFieldCell+Rik.h"

#define ICON_WIDTH	16


@implementation NSSearchFieldCell (RikTheme)

- (void) drawWithFrame: (NSRect)cellFrame inView: (NSView*)controlView
{
  NSRect frame = cellFrame;
  [_search_button_cell drawWithFrame: [self searchButtonRectForBounds: cellFrame] 
		       inView: controlView];
  [super drawWithFrame: [self searchTextRectForBounds: cellFrame ] 
	 inView: controlView];
  if ([[self stringValue] length] > 0)
    [_cancel_button_cell drawWithFrame: [self cancelButtonRectForBounds: cellFrame] 
		       inView: controlView];
}

- (NSRect) searchTextRectForBounds: (NSRect)rect
{
  NSRect search, text, clear, part;

  if (!_search_button_cell)
    {
      part = rect;
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
	NSBezierPath* roundedSearchFieldPath = [NSBezierPath bezierPathWithRoundedRect: rect
                                                                       xRadius: radius
                                                                       yRadius: radius];
	[roundedSearchFieldPath setLineWidth: 0.2];
	
	[[NSColor whiteColor] setFill];
	[roundedSearchFieldPath fill];
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
          frame.origin.x += 3;
          frame.size.width -= 14;
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
@end
