
#import "CALayer+Night.h"
#import <objc/runtime.h>

@interface CALayer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation CALayer (Night)

- (DTColorPicker)dt_shadowColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_shadowColorPicker));
}

- (void)setQb_shadowColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_shadowColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.shadowColor = picker(self.dt_manager.themeVersion).CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setShadowColor:))];
}

- (DTColorPicker)dt_borderColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_borderColorPicker));
}

- (void)setQb_borderColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_borderColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.borderColor = picker(self.dt_manager.themeVersion).CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setBorderColor:))];
}

- (DTColorPicker)dt_backgroundColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_backgroundColorPicker));
}

- (void)setQb_backgroundColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_backgroundColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.backgroundColor = picker(self.dt_manager.themeVersion).CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setBackgroundColor:))];
}

- (void)night_updateColor {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DTColorPicker  _Nonnull picker, BOOL * _Nonnull stop) {
        CGColorRef result = picker(self.dt_manager.themeVersion).CGColor;
        [UIView animateWithDuration:DTNightVersionAnimationDuration
                         animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             if ([selector isEqualToString:NSStringFromSelector(@selector(setShadowColor:))]) {
                                 [self setShadowColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBorderColor:))]) {
                                 [self setBorderColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundColor:)) ]) {
                                 [self setBackgroundColor:result];
                             }
#pragma clang diagnostic pop
                         }];
    }];
}
@end
