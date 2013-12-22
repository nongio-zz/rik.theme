#import "Rik.h"

@interface Rik(RikStepper)

@end

@implementation Rik(RikStepper)
- (NSRect) stepperUpButtonRectWithFrame: (NSRect)frame
{
  NSRect upRect = frame;
  upRect.size.width = 12;
  upRect.size.height = 12;
  upRect.origin.x += 1.5;
  upRect.origin.y = NSMinY(frame) + 11;
  return upRect;
}

- (NSRect) stepperDownButtonRectWithFrame: (NSRect)frame
{

  NSRect upRect = frame;
  upRect.size.width = 12;
  upRect.size.height = 12;
  upRect.origin.x += 1.5;
  upRect.origin.y = NSMinY(frame);
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
  [image drawInRect: NSInsetRect(aRect, 3, 3)
	   fromRect: NSZeroRect
	  operation: NSCompositeSourceOver
	   fraction: 1
     respectFlipped: YES
	      hints: nil];
}

- (void) drawStepperHighlightUpButton: (NSRect)aRect
{
  NSGradient * fillgradient = [self _buttonGradientWithColor:[NSColor selectedControlColor]];
  CGFloat roundedRectangleCornerRadius = 4;
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
  [image drawInRect: NSInsetRect(aRect, 3, 3)
	   fromRect: NSZeroRect
	  operation: NSCompositeSourceOver
	   fraction: 1
     respectFlipped: YES
	      hints: nil];
}

- (void) drawStepperDownButton: (NSRect)aRect
{
  NSImage *image = [NSImage imageNamed: @"common_ArrowDown"];
  [image drawInRect: NSInsetRect(aRect, 3, 3)
	   fromRect: NSZeroRect
	  operation: NSCompositeSourceOver
	   fraction: 1
     respectFlipped: YES
	      hints: nil];
}

- (void) drawStepperHighlightDownButton: (NSRect)aRect
{
  NSGradient * fillgradient = [self _buttonGradientWithColor:[NSColor selectedControlColor]];
  CGFloat roundedRectangleCornerRadius = 4;
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
  [image drawInRect: NSInsetRect(aRect, 3, 3)
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

  NSRect frame = NSMakeRect(cellFrame.origin.x+2.5, cellFrame.origin.y+0.5, 11, 22);

  CGFloat radius = 4;
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

  NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
  [strokeColor setStroke];
  [roundedRectanglePath setLineWidth: 1];
  [roundedRectanglePath stroke];
}
@end
