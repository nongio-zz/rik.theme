#import "Rik.h"

#import <AppKit/AppKit.h>
#import <GNUstepGUI/GSWindowDecorationView.h>

@implementation Rik

+ (NSColor *) controlStrokeColor
{

  return RETAIN([NSColor colorWithCalibratedRed: 0.4
                                          green: 0.4
                                           blue: 0.4
                                          alpha: 1]);
}
@end

