#import "Rik.h"
#include <AppKit/NSAnimation.h>

@interface Rik(RikButton)
{
}
@end


@interface NSButtonCell(RikDefaultButtonAnimation)
  @property (nonatomic, copy) NSNumber* isDefaultButton;
  @property (nonatomic, copy) NSNumber* pulseProgress;
@end
