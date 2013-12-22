#include <AppKit/AppKit.h>
#include "MyController.h"

@interface TestView : NSView
{

}
@end

@implementation TestView
- (void) drawRect: (NSRect)aRect
{
}

@end

@implementation MyController

- (void) awakeFromNib
{
	TestView *view1 = [[TestView alloc] initWithFrame: NSMakeRect(0, 0, 800, 800)];

  NSSegmentedControl * mySegmentControl = [[NSSegmentedControl alloc]
                               initWithFrame: NSMakeRect(20,380,400,20)];

  [mySegmentControl setSegmentCount:5];
  [mySegmentControl setLabel:@"First" forSegment:0];
  [mySegmentControl setLabel:@"Second" forSegment:1];
  [[window contentView] addSubview: mySegmentControl];

}

@end
