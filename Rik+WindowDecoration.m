#import "Rik.h"

@interface Rik(RikWindowDecoration)

@end


#define TITLE_HEIGHT 24.0
#define RESIZE_HEIGHT 9.0
#define WINDOW_CORNER_RADIUS 6

@implementation Rik(RikWindowDecoration)

static NSDictionary *titleTextAttributes[3] = {nil, nil, nil};


- (float) resizebarHeight {
    return RESIZE_HEIGHT;
}

- (float) titlebarHeight {
    return TITLE_HEIGHT;
}

- (void) drawWindowBackground: (NSRect) frame view: (NSView*) view
{
  //TODO this color should be taken from thematic?
  NSColor* backgroundColor = [NSColor colorWithCalibratedRed: 0.93
                                                       green: 0.93
                                                        blue: 0.93
                                                       alpha: 1];

  NSColor *borderColor = [Rik controlStrokeColor];

  //i want to draw over the resize bar
  frame.size.height += RESIZE_HEIGHT;
  frame.origin.y -= RESIZE_HEIGHT;
  frame.origin.x -= 1;
  frame.size.width += 1;
  NSRect backgroundRect = NSOffsetRect(frame, 0.5, 0.5);

  NSRect backgroundInnerRect = NSInsetRect( backgroundRect,
                                            WINDOW_CORNER_RADIUS,
                                            WINDOW_CORNER_RADIUS);
  NSBezierPath* backgroundPath = [NSBezierPath bezierPath];
  [backgroundPath setLineWidth: 1];

  [backgroundPath appendBezierPathWithArcWithCenter: NSMakePoint(NSMinX(backgroundInnerRect), NSMinY(backgroundInnerRect))
                                             radius: WINDOW_CORNER_RADIUS startAngle: 180 endAngle: 270];
  [backgroundPath appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(backgroundInnerRect), NSMinY(backgroundInnerRect))
                                             radius: WINDOW_CORNER_RADIUS startAngle: 270 endAngle: 360];
  [backgroundPath lineToPoint: NSMakePoint(NSMaxX(backgroundRect), NSMaxY(backgroundRect))];
  [backgroundPath lineToPoint: NSMakePoint(NSMinX(backgroundRect), NSMaxY(backgroundRect))];
  [backgroundPath closePath];

  [backgroundColor setFill];
  [borderColor setStroke];

  [backgroundPath fill];
  [backgroundPath stroke];
}

- (void) drawWindowBorder: (NSRect)rect
                withFrame: (NSRect)frame
             forStyleMask: (unsigned int)styleMask
                    state: (int)inputState
                 andTitle: (NSString*)title
{
  if (styleMask & (NSTitledWindowMask | NSClosableWindowMask
                  | NSMiniaturizableWindowMask))
    {
      NSRect titleRect;

      titleRect = NSMakeRect(0.0, frame.size.height - TITLE_HEIGHT,
                                frame.size.width, TITLE_HEIGHT);

      if (NSIntersectsRect(rect, titleRect))
        [self drawtitleRect: titleRect
              forStyleMask: styleMask
              state: inputState
              andTitle: title];

    }
}


- (void) drawtitleRect: (NSRect)titleRect
             forStyleMask: (unsigned int)styleMask
                    state: (int)inputState
                 andTitle: (NSString*)title
{

  if (!titleTextAttributes[0])
    {
      [self prepareTitleTextAttributes];
    }

  NSRect workRect;

  workRect = titleRect;
  workRect.origin.x -= 0.5;
  workRect.origin.y -= 0.5;
  [self drawTitleBarBackground:workRect];

  // Draw the title.
  if (styleMask & NSTitledWindowMask)
    {
      NSSize titleSize;
      if (styleMask & NSMiniaturizableWindowMask)
        {
          workRect.origin.x += 17;
          workRect.size.width -= 17;
        }
      if (styleMask & NSClosableWindowMask)
        {
          workRect.size.width -= 17;
        }
      titleSize = [title sizeWithAttributes: titleTextAttributes[inputState]];
      if (titleSize.width <= workRect.size.width)
        workRect.origin.x = NSMidX(workRect) - titleSize.width / 2;
      workRect.origin.y = NSMidY(workRect) - titleSize.height / 2;
      workRect.size.height = titleSize.height;
      [title drawInRect: workRect
          withAttributes: titleTextAttributes[inputState]];
    }
}

- (void) drawTitleBarBackground: (NSRect)rect {

  NSColor* borderColor = [Rik controlStrokeColor];
  NSGradient* gradient = [self _windowTitlebarGradient];

  CGFloat titleBarCornerRadius = WINDOW_CORNER_RADIUS;
  NSRect titleRect = rect;
  titleRect.origin.x += 1;
  titleRect.size.width -= 1;
  NSRectFillUsingOperation(titleRect, NSCompositeClear);
  NSRect titleinner = NSInsetRect(titleRect, titleBarCornerRadius, titleBarCornerRadius);
  NSBezierPath* titleBarPath = [NSBezierPath bezierPath];
  [titleBarPath moveToPoint: NSMakePoint(NSMinX(titleRect), NSMinY(titleRect))];
  [titleBarPath lineToPoint: NSMakePoint(NSMaxX(titleRect), NSMinY(titleRect))];
  [titleBarPath appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(titleinner), NSMaxY(titleinner))
                                           radius: titleBarCornerRadius
                                       startAngle: 0
                                         endAngle: 90];
  [titleBarPath appendBezierPathWithArcWithCenter: NSMakePoint(NSMinX(titleinner), NSMaxY(titleinner))
                                           radius: titleBarCornerRadius
                                       startAngle: 90
                                         endAngle: 180];
  [titleBarPath closePath];

  NSBezierPath* linePath = [NSBezierPath bezierPath];
  [linePath moveToPoint: NSMakePoint(NSMinX(titleRect), NSMinY(titleRect)+1)];
  [linePath lineToPoint:  NSMakePoint(NSMaxX(titleRect), NSMinY(titleRect)+1)];

  [borderColor setStroke];
  [gradient drawInBezierPath: titleBarPath angle: -90];
  [titleBarPath setLineWidth: 1];
  [titleBarPath stroke];
  [linePath setLineWidth: 1];
  [linePath stroke];
}

- (void) drawResizeBarRect: (NSRect)resizeBarRect
{
  //I don't want to draw the resize bar
  //TODO change the mouse cursor on hover
}

- (void)prepareTitleTextAttributes
{

  NSMutableParagraphStyle *p;
  NSColor *keyColor, *normalColor, *mainColor;

  p = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  [p setLineBreakMode: NSLineBreakByClipping];


  normalColor = [NSColor colorWithCalibratedRed: 0.1 green: 0.1 blue: 0.1 alpha: 1];

  mainColor = normalColor;
  keyColor = normalColor;

  titleTextAttributes[0] = [[NSMutableDictionary alloc]
    initWithObjectsAndKeys:
      [NSFont titleBarFontOfSize: 0], NSFontAttributeName,
      keyColor, NSForegroundColorAttributeName,
      p, NSParagraphStyleAttributeName,
      nil];

  titleTextAttributes[1] = [[NSMutableDictionary alloc]
    initWithObjectsAndKeys:
    [NSFont titleBarFontOfSize: 0], NSFontAttributeName,
    normalColor, NSForegroundColorAttributeName,
    p, NSParagraphStyleAttributeName,
    nil];

  titleTextAttributes[2] = [[NSMutableDictionary alloc]
    initWithObjectsAndKeys:
    [NSFont titleBarFontOfSize: 0], NSFontAttributeName,
    mainColor, NSForegroundColorAttributeName,
    p, NSParagraphStyleAttributeName,
    nil];

    RELEASE(p);
}



@end
