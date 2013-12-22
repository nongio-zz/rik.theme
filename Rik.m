#import "Rik.h"

#import <AppKit/AppKit.h>
#import <GNUstepGUI/GSWindowDecorationView.h>

@implementation Rik

+ (NSColor *) controlStrokeColor
{

  return RETAIN([NSColor colorWithCalibratedRed: 0.3
                                          green: 0.3
                                           blue: 0.3
                                          alpha: 1]);
}
@end

