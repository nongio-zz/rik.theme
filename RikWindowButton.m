#import "RikWindowButton.h"
#import "RikWindowButtonCell.h"

@implementation RikWindowButton

+ (void) initialize
{
  if (self == [RikWindowButton class])
    {
      [self setVersion: 1];
      [self setCellClass: [RikWindowButtonCell class]];
    }
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
