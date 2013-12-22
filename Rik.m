#import "Rik.h"

#import <AppKit/AppKit.h>
#import <GNUstepGUI/GSWindowDecorationView.h>

@implementation Rik

+ (NSColor *) controlStrokeColor
{

  return RETAIN([NSColor colorWithCalibratedRed: 0.2
                                          green: 0.2
                                           blue: 0.2
                                          alpha: 1]);
}
@end

