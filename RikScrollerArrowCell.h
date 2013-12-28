#import <AppKit/NSButtonCell.h>

typedef enum {
  RikScrollerArrowLeft,
  RikScrollerArrowRight,
  RikScrollerArrowUp,
  RikScrollerArrowDown
} RikScrollerArrowType;

@interface RikScrollerArrowCell : NSButtonCell
{
  RikScrollerArrowType scroller_arrow_type;
}
-(void) setArrowType: (RikScrollerArrowType) t;
@end

