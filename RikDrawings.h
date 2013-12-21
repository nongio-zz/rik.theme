#include "Rik.h"

void NSRoundRectDraw(NSRect r, float radius);
void NSRoundRectFill(NSRect r, float radius);

@interface Rik(RikDrawings)

- (NSGradient *) _buttonGradientWithColor:(NSColor*) baseColor;
- (NSGradient *) _windowTitlebarGradient;
@end
