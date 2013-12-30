#import "Rik.h"
#import "Rik+Stepper.h"

@implementation Rik(RikStepper)
- (NSRect) stepperUpButtonRectWithFrame: (NSRect)frame
{
  NSRect upRect = frame;
  upRect.size.width = 13;
  upRect.size.height = 12;
  upRect.origin.x = frame.origin.x + frame.size.width/2 - 6;
  upRect.origin.y = frame.origin.y + frame.size.height/2-1;
  return upRect;
}

- (NSRect) stepperDownButtonRectWithFrame: (NSRect)frame
{

  NSRect upRect = frame;
  upRect.size.width = 13;
  upRect.size.height = 12;
  upRect.origin.x = frame.origin.x + frame.size.width/2 - 6;
  upRect.origin.y = frame.origin.y + frame.size.height/2 - 11;
  return upRect;
}

- (void) drawStepperBorder: (NSRect)frame
{
}

- (NSRect) drawStepperLightButton: (NSRect)border : (NSRect)clip
{
  return NSZeroRect;
}

- (void) drawStepperUpButton: (NSRect)aRect
{
  NSImage *image = [NSImage imageNamed: @"common_ArrowUp"];
  [image drawInRect: NSInsetRect(aRect, 4, 4)
           fromRect: NSZeroRect
          operation: NSCompositeSourceOver
           fraction: 1
     respectFlipped: YES
              hints: nil];
}

- (void) drawStepperHighlightUpButton: (NSRect)aRect
{
  NSGradient * fillgradient = [self _buttonGradientWithColor:[NSColor selectedControlColor]];
  CGFloat roundedRectangleCornerRadius = 5;
  NSRect roundedRectangleRect = aRect;
  NSRect roundedRectangleInnerRect = NSInsetRect(roundedRectangleRect, roundedRectangleCornerRadius, roundedRectangleCornerRadius);
  NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPath];
  [roundedRectanglePath moveToPoint: NSMakePoint(NSMinX(roundedRectangleRect), NSMinY(roundedRectangleRect))];
  [roundedRectanglePath lineToPoint: NSMakePoint(NSMaxX(roundedRectangleRect), NSMinY(roundedRectangleRect))];
  [roundedRectanglePath appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(roundedRectangleInnerRect), NSMaxY(roundedRectangleInnerRect)) radius: roundedRectangleCornerRadius startAngle: 0 endAngle: 90];
  [roundedRectanglePath appendBezierPathWithArcWithCenter: NSMakePoint(NSMinX(roundedRectangleInnerRect), NSMaxY(roundedRectangleInnerRect)) radius: roundedRectangleCornerRadius startAngle: 90 endAngle: 180];
  [roundedRectanglePath closePath];
  [fillgradient drawInBezierPath:roundedRectanglePath angle:90];
  NSImage *image = [NSImage imageNamed: @"common_ArrowUp"];
  [image drawInRect: NSInsetRect(aRect, 4, 4)
           fromRect: NSZeroRect
          operation: NSCompositeSourceOver
           fraction: 1
     respectFlipped: YES
              hints: nil];
}

- (void) drawStepperDownButton: (NSRect)aRect
{
  NSImage *image = [NSImage imageNamed: @"common_ArrowDown"];
  [image drawInRect: NSInsetRect(aRect, 4, 4)
           fromRect: NSZeroRect
          operation: NSCompositeSourceOver
           fraction: 1
     respectFlipped: YES
              hints: nil];
}

- (void) drawStepperHighlightDownButton: (NSRect)aRect
{
  NSGradient * fillgradient = [self _buttonGradientWithColor:[NSColor selectedControlColor]];
  CGFloat roundedRectangleCornerRadius = 5;
  NSRect roundedRectangleRect = aRect;
  NSRect roundedRectangleInnerRect = NSInsetRect(roundedRectangleRect, roundedRectangleCornerRadius, roundedRectangleCornerRadius);
  NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPath];
  [roundedRectanglePath appendBezierPathWithArcWithCenter: NSMakePoint(NSMinX(roundedRectangleInnerRect), NSMinY(roundedRectangleInnerRect)) radius: roundedRectangleCornerRadius startAngle: 180 endAngle: 270];
  [roundedRectanglePath appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(roundedRectangleInnerRect), NSMinY(roundedRectangleInnerRect)) radius: roundedRectangleCornerRadius startAngle: 270 endAngle: 360];
  [roundedRectanglePath lineToPoint: NSMakePoint(NSMaxX(roundedRectangleRect), NSMaxY(roundedRectangleRect))];
  [roundedRectanglePath lineToPoint: NSMakePoint(NSMinX(roundedRectangleRect), NSMaxY(roundedRectangleRect))];
  [roundedRectanglePath closePath];
  [fillgradient drawInBezierPath:roundedRectanglePath angle:90];
  NSImage *image = [NSImage imageNamed: @"common_ArrowDown"];
  [image drawInRect: NSInsetRect(aRect, 4, 4)
           fromRect: NSZeroRect
          operation: NSCompositeSourceOver
           fraction: 1
     respectFlipped: YES
              hints: nil];
}
- (void) drawStepperCell: (NSCell*)cell
               withFrame: (NSRect)cellFrame
                  inView: (NSView*)controlView
             highlightUp: (BOOL)highlightUp
           highlightDown: (BOOL)highlightDown
{
  const NSRect upRect = [self stepperUpButtonRectWithFrame: cellFrame];
  const NSRect downRect = [self stepperDownButtonRectWithFrame: cellFrame];

  NSRect frame = NSMakeRect(cellFrame.origin.x + cellFrame.size.width/2 - 6, cellFrame.origin.y + cellFrame.size.height/2 - 11, 13, 22);

  CGFloat radius = 5;
  NSGradient * fillgradient = [self _buttonGradientWithColor:[NSColor controlBackgroundColor]];
  NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect:frame  xRadius: radius yRadius: radius];
  [fillgradient drawInBezierPath:roundedRectanglePath angle:90];

  if (highlightUp)
    [self drawStepperHighlightUpButton: upRect];
  else
    [self drawStepperUpButton: upRect];
  if (highlightDown)
    [self drawStepperHighlightDownButton: downRect];
  else
    [self drawStepperDownButton: downRect];

  NSColor* strokeColor = [Rik controlStrokeColor];
  [strokeColor setStroke];
  [roundedRectanglePath setLineWidth: 1];
  [roundedRectanglePath stroke];
}
-(NSBezierPath *) stepperBezierPathWithFrame:(NSRect)frame
{
  CGFloat radius = 5;
  frame = NSMakeRect(frame.origin.x + frame.size.width/2 - 6, frame.origin.y + frame.size.height/2 - 11, 13, 22);
  NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect:frame  xRadius: radius yRadius: radius];
  return RETAIN(roundedRectanglePath);
}
@end
