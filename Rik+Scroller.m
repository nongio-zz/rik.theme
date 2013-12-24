#include "Rik.h"
#include "RikScrollerKnobCell.h"
#include "RikScrollerKnobSlotCell.h"

@interface Rik(RikScroller)

@end

@implementation Rik(RikScroller)

/* NSScroller themeing. */

- (NSButtonCell*) cellForScrollerArrow: (NSScrollerArrow)arrow
			    horizontal: (BOOL)horizontal
{
  NSButtonCell	*cell;
  NSString	*name;

  cell = [NSButtonCell new];
  [cell setBezelStyle: NSRegularSquareBezelStyle];
  if (horizontal)
    {
      if (arrow == NSScrollerDecrementArrow)
	{
	  [cell setHighlightsBy:
	    NSChangeBackgroundCellMask | NSContentsCellMask];
	  [cell setImage: [NSImage imageNamed: @"common_ArrowLeft"]];
	  [cell setAlternateImage: [NSImage imageNamed: @"common_ArrowLeftH"]];
	  [cell setImagePosition: NSImageOnly];
          name = GSScrollerLeftArrow;
	}
      else
	{
	  [cell setHighlightsBy:
	    NSChangeBackgroundCellMask | NSContentsCellMask];
	  [cell setImage: [NSImage imageNamed: @"common_ArrowRight"]];
	  [cell setAlternateImage: [NSImage imageNamed: @"common_ArrowRightH"]];
	  [cell setImagePosition: NSImageOnly];
          name = GSScrollerRightArrow;
	}
    }
  else
    {
      if (arrow == NSScrollerDecrementArrow)
	{
	  [cell setHighlightsBy:
	    NSChangeBackgroundCellMask | NSContentsCellMask];
	  [cell setImage: [NSImage imageNamed: @"common_ArrowUp"]];
	  [cell setAlternateImage: [NSImage imageNamed: @"common_ArrowUpH"]];
	  [cell setImagePosition: NSImageOnly];
          name = GSScrollerUpArrow;
	}
      else
	{
	  [cell setHighlightsBy:
	    NSChangeBackgroundCellMask | NSContentsCellMask];
	  [cell setImage: [NSImage imageNamed: @"common_ArrowDown"]];
	  [cell setAlternateImage: [NSImage imageNamed: @"common_ArrowDownH"]];
	  [cell setImagePosition: NSImageOnly];
          name = GSScrollerDownArrow;
	}
    }
  [self setName: name forElement: cell temporary: YES];
  RELEASE(cell);
  return cell;
}

- (NSCell*) cellForScrollerKnob: (BOOL)horizontal
{
  NSButtonCell	*cell;

  cell = [RikScrollerKnobCell new];
  [cell setButtonType: NSMomentaryChangeButton];
  [cell setBezelStyle: NSRoundedBezelStyle];
  [cell setImagePosition: NSImageOnly];

  NSColor* bc = [NSColor colorWithCalibratedRed: 0.4
                                          green: 0.4
                                           blue: 0.4
                                          alpha: 1];
  [cell setTitle: @""];
  if (horizontal)
    {
      [self setName: GSScrollerHorizontalKnob forElement: cell temporary: YES];
    }
  else
    {
      [self setName: GSScrollerVerticalKnob forElement: cell temporary: YES];
    }
  RELEASE(cell);
  return cell;
}

- (NSCell*) cellForScrollerKnobSlot: (BOOL)horizontal
{
  GSDrawTiles   		*tiles;
  RikScrollerKnobSlotCell	*cell;
  NSColor			*color;
  NSString      		*name;

  if (horizontal)
    {
      name = GSScrollerHorizontalSlot;
    }
  else
    {
      name = GSScrollerVerticalSlot;
    }

  tiles = [self tilesNamed: name state: GSThemeNormalState];
  color = [self colorNamed: name state: GSThemeNormalState];

  cell = [RikScrollerKnobSlotCell new];
  [cell setBordered: false];
  [cell setTitle: nil];
  [cell setHorizontal: horizontal];
  [self setName: name forElement: cell temporary: YES];

  if (color == nil)
    {
      color = [NSColor scrollBarColor];
    }
  [cell setBackgroundColor: color];
  RELEASE(cell);
  return cell;
}
// REMEMBER THIS SETTING
- (float) defaultScrollerWidth
{
  NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
  float defaultScrollerWidth;

  if ([defs objectForKey: @"GSScrollerDefaultWidth"] != nil)
    {
      defaultScrollerWidth = [defs floatForKey: @"GSScrollerDefaultWidth"];
    }
  else
    {
      defaultScrollerWidth = 12.0;
    }
  return defaultScrollerWidth;
}

- (BOOL) scrollViewUseBottomCorner
{
  NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
  if ([defs objectForKey: @"GSScrollViewUseBottomCorner"] != nil)
    {
      return [defs boolForKey: @"GSScrollViewUseBottomCorner"];
    }
  return YES;
}

- (BOOL) scrollViewScrollersOverlapBorders
{
  NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
  if ([defs objectForKey: @"GSScrollViewScrollersOverlapBorders"] != nil)
    {
      return [defs boolForKey: @"GSScrollViewScrollersOverlapBorders"];
    }
  return NO;
}

@end
