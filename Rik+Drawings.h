#import "Rik.h"

void NSRoundRectDraw(NSRect r, float radius);
void NSRoundRectFill(NSRect r, float radius);

@interface Rik(RikDrawings)

- (NSGradient *) _bezelGradientWithColor:(NSColor*) baseColor;
- (NSGradient *) _buttonGradientWithColor:(NSColor*) baseColor;
- (NSGradient *) _windowTitlebarGradient;
- (NSRect) drawInnerGrayBezel: (NSRect)border withClip: (NSRect)clip;
- (NSBezierPath*) buttonBezierPathWithRect: (NSRect)frame andStyle: (int) style;
@end
