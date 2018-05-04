
#import "UIView+DTNBaseNightModel.h"
#import <objc/runtime.h>
#import "DTNightVersion.h"

@implementation UIView (DTNBaseNightModel)

- (CGFloat)cornerRadius
{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}


- (CGFloat)borderWidth
{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}


- (UIColor *)borderColor
{
    return objc_getAssociatedObject(self, @selector(borderColor));
}
- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}


- (NSString *)borderC4N{
    return objc_getAssociatedObject(self, @selector(borderC4N));
}
- (void)setBorderC4N:(NSString *)borderC4N{
    self.layer.dt_borderColorPicker = DTColorPickerWithKey(borderC4N);
}

- (NSString *)bgColor4N{
    return objc_getAssociatedObject(self, @selector(bgColor4N));
}
- (void)setBgColor4N:(NSString *)bgColor4N{
    self.dt_backgroundColorPicker = DTColorPickerWithKey(bgColor4N);
}

- (BOOL)hidden4N{
    return objc_getAssociatedObject(self, @selector(hidden4N));
}
- (void)setHidden4N:(BOOL)hidden4N{
    if (hidden4N) {
        self.hidden = [self.dt_manager.themeVersion isEqualToString:DTThemeVersionNormal];
    }
}


@end
