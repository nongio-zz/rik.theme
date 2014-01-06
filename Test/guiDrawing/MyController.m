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
  NSButton * abutton = [[NSButton alloc] initWithFrame: NSMakeRect (20, 330, 71, 27)];
  [abutton setBordered: YES];
  [abutton setTitle:  _(@"OK")];
  [abutton setImagePosition: NSImageRight]; 
  [abutton setImage: [NSImage imageNamed: @"common_ret"]];
  [abutton setAlternateImage: [NSImage imageNamed: @"common_retH"]];
  [abutton setAutoresizingMask: NSViewMinXMargin];
  [[window contentView] addSubview: abutton];

  [mySegmentControl setSegmentCount:5];
  [mySegmentControl setLabel:@"First" forSegment:0];
  [mySegmentControl setLabel:@"Second" forSegment:1];
  [mySegmentControl setLabel:@"Third" forSegment:2];
  [[window contentView] addSubview: mySegmentControl];

  [window setDefaultButtonCell: [abutton cell]];
}

@end
