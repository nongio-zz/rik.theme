#include <AppKit/AppKit.h>
#import <Foundation/NSUserDefaults.h>
#import <GNUstepGUI/GSTheme.h>

@interface Rik: GSTheme
+ (NSColor *) controlStrokeColor;
- (void) drawPathButton: (NSBezierPath*) path
                     in: (NSCell*)cell
			            state: (GSThemeControlState) state;
@end


#import "Rik+Drawings.h"
