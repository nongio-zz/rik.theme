#include "Rik.h"

@interface Rik(RikProgressIndicator)

@end

@implementation Rik(RikProgressIndicator)


// progress indicator drawing methods
static NSColor *fillColour = nil;
#define MaxCount 10
static int indeterminateMaxCount = MaxCount;
static int spinningMaxCount = MaxCount;
static NSColor *indeterminateColors[MaxCount];
static NSImage *spinningImages[MaxCount];

- (void) initProgressIndicatorDrawing
{
  int i;

  // FIXME: Should come from defaults and should be reset when defaults change
  // FIXME: Should probably get the color from the color extension list (see NSToolbar)
  fillColour = RETAIN([NSColor controlShadowColor]);

  // Load images for indeterminate style
  for (i = 0; i < MaxCount; i++)
    {
      NSString *imgName = [NSString stringWithFormat: @"common_ProgressIndeterminate_%d", i + 1];
      NSImage *image = [NSImage imageNamed: imgName];

      if (image == nil)
        {
          indeterminateMaxCount = i;
          break;
        }
          indeterminateColors[i] = RETAIN([NSColor colorWithPatternImage: image]);
    }

  // Load images for spinning style
  for (i = 0; i < MaxCount; i++)
    {
      NSString *imgName = [NSString stringWithFormat: @"common_ProgressSpinning_%d", i + 1];
      NSImage *image = [NSImage imageNamed: imgName];

      if (image == nil)
        {
          spinningMaxCount = i;
          break;
        }
      spinningImages[i] = RETAIN(image);
    }
}

- (void) drawProgressIndicator: (NSProgressIndicator*)progress
                    withBounds: (NSRect)bounds
                      withClip: (NSRect)rect
                       atCount: (int)count
                      forValue: (double)val
{
  NSRect r;
  if (fillColour == nil)
    {
      [self initProgressIndicatorDrawing];
    }
  // Draw the Bezel
  if ([progress isBezeled])
    {
      // Calc the inside rect to be drawn
      r = [self drawProgressIndicatorBezel: bounds withClip: rect];
    }
  else
    {
      r = bounds;
    }

  if ([progress style] == NSProgressIndicatorSpinningStyle)
    {
      NSRect imgBox = {{0,0}, {0,0}};

      if (spinningMaxCount != 0)
        {
          count = count % spinningMaxCount;
          imgBox.size = [spinningImages[count] size];
          [spinningImages[count] drawInRect: r
                  fromRect: imgBox
                operation: NSCompositeSourceOver
                  fraction: 1.0];
        }
     }
   else
     {
       if ([progress isIndeterminate])
         {
	   if (indeterminateMaxCount != 0)
	     {
	       count = count % indeterminateMaxCount;
	       [indeterminateColors[count] set];
	       NSRectFill(r);
	     }
         }
       else
         {
           // Draw determinate
           if ([progress isVertical])
             {
               float height = NSHeight(r) * val;

               if ([progress isFlipped])
                 {
                   // Compensate for the flip
                   r.origin.y += NSHeight(r) - height;
                 }
               r.size.height = height;
             }
           else
             {
               r.size.width = NSWidth(r) * val;
             }
           r = NSIntersectionRect(r, rect);
           if (!NSIsEmptyRect(r))
             {
               [self drawProgressIndicatorBarDeterminate: (NSRect)r withOrientation:[progress isVertical]];

                NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0.624
                                                                green: 0.624
                                                                  blue: 0.624
                                                                alpha: 1];

                NSRect borderRect = NSMakeRect(
                    NSMinX(bounds) + 0.5,
                    NSMinY(bounds) + 0.5,
                    floor(NSWidth(bounds)-1),
                    NSHeight(bounds)-1
                );
                NSBezierPath* emptyRectanglePath = [NSBezierPath bezierPathWithRoundedRect: borderRect
                                                                                  xRadius: 3
                                                                                  yRadius: 3];
                if(val < 1.0)
                  {
                  if([progress isVertical])
                    {
                      [emptyRectanglePath moveToPoint: NSMakePoint(NSMinX(r), NSMinY(r))];
                      [emptyRectanglePath lineToPoint: NSMakePoint(NSMaxX(r), NSMinY(r))];
                    }
                  else
                    {
                      [emptyRectanglePath moveToPoint: NSMakePoint(floor(NSMaxX(r))+0.5, NSMaxY(r))];
                      [emptyRectanglePath lineToPoint: NSMakePoint(floor(NSMaxX(r))+0.5, NSMinY(r))];
                    }
                  }
                [strokeColor setStroke];
                [emptyRectanglePath setLineWidth: 1];
                [emptyRectanglePath stroke];

             }
         }
     }
}

- (NSRect) drawProgressIndicatorBezel: (NSRect)bounds withClip: (NSRect) rect
{
    return [self drawGrayBezel: bounds withClip: rect];
}

- (void) drawProgressIndicatorBarDeterminate: (NSRect)bounds withOrientation:(BOOL) isVertical
{

  //// Color Declarations
  NSColor* baseColor = [NSColor colorWithCalibratedRed: 0.376 green: 0.761 blue: 0.957 alpha: 1];
  NSColor* lightColor = [baseColor highlightWithLevel: 0.5];
  NSColor* lightColor2 = [NSColor colorWithCalibratedHue: [baseColor hueComponent] saturation: 0.2 brightness: [baseColor brightnessComponent] alpha: [baseColor alphaComponent]];
  NSColor* saturate = [NSColor colorWithCalibratedHue: [baseColor hueComponent] saturation: 0.8 brightness: [baseColor brightnessComponent] alpha: [baseColor alphaComponent]];

  //// Gradient Declarations
  NSGradient* progressbarGradient = [[NSGradient alloc] initWithColorsAndLocations: 
      lightColor, 0.0, 
      baseColor, 0.45, 
      saturate, 0.55, 
      lightColor2, 1.0, nil];


  //// fullrectange Drawing
  NSBezierPath* fullrectangePath = [NSBezierPath bezierPathWithRoundedRect:bounds  xRadius: 3 yRadius: 3];

  int angle = 90;
  //maybe there is a better method to determine the orientation
  if(isVertical)
    angle = 0;
  [progressbarGradient drawInBezierPath: fullrectangePath angle: angle];


}

@end
