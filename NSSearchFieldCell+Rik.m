#import "Rik.h"
#import "NSSearchFieldCell+Rik.h"

#define ICON_WIDTH	16


@implementation NSSearchFieldCell (RikTheme)

- (void) drawWithFrame: (NSRect)cellFrame inView: (NSView*)controlView
{
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
      // nothing to split off
      part = rect;
    }
  else
  {
    NSDivideRect(rect, &search, &part, ICON_WIDTH, NSMinXEdge);
  }

  text = part;

  return text;
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
@end
