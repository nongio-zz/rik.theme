#include <AppKit/AppKit.h>
#include "MyController.h"

@interface TestView : NSView
{

}
@end

@implementation TestView
- (void) drawRect: (NSRect)aRect
{

  /*

  NSColor* baseColor1 = [NSColor colorWithCalibratedRed: 1 green: 0 blue: 0 alpha: 1];
  NSColor* baseColor2 = [NSColor colorWithCalibratedRed: 0.969 green: 0.753 blue: 0.404 alpha: 1];
  NSColor* baseColor3 = [NSColor colorWithCalibratedRed: 0.322 green: 0.778 blue: 0.244 alpha: 1];
  [self drawBallWithRect: NSMakeRect(100.5, 250.5, 15, 15) andColor: baseColor1];
  [self drawBallWithRect: NSMakeRect(125.5, 250.5, 15, 15) andColor: baseColor2];
  [self drawBallWithRect: NSMakeRect(150.5, 250.5, 15, 15) andColor: baseColor3];

*/
}

@end

@implementation MyController

- (void) awakeFromNib
{
	TestView *view1 = [[TestView alloc] initWithFrame: NSMakeRect(0, 0, 800, 800)];
//  [[window contentView] addSubview: view1];
//  NSButton * b = [NSWindow standardWindowButton: NSWindowCloseButton
//                       forStyleMask: 0];
//  [b setFrame: NSMakeRect(600,200, 200, 200)];
//  [[window contentView] addSubview: b];
//  [window setDefaultButtonCell: [abutton cell]];
//  NSSegmentedControl * mySegmentControl = [[NSSegmentedControl alloc]
//                               initWithFrame: NSMakeRect(100,100,400,20)];
//
//  [mySegmentControl setSegmentCount:5];
//  [mySegmentControl setLabel:@"First" forSegment:0];
//  [mySegmentControl setLabel:@"Second" forSegment:1];
//  [[window contentView] addSubview: mySegmentControl];

}

@end
