#import "RikWindowButton.h"
#import "RikWindowButtonCell.h"

@implementation RikWindowButton

+ (Class) cellClass
{
  return [RikWindowButtonCell class];
}
- (void) setBaseColor: (NSColor*)c
{
  [_cell setBaseColor: c];
}
- (BOOL) isFlipped
{
  return NO;
}

@end
