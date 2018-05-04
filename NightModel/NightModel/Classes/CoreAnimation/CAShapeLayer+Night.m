
#import "CAShapeLayer+Night.h"
#import "NSObject+Night.h"
#import <objc/runtime.h>

@interface CAShapeLayer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation CAShapeLayer (Night)

- (DTColorPicker)dt_strokeColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_strokeColorPicker));
}

- (void)setQb_strokeColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_strokeColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.strokeColor = picker(self.dt_manager.themeVersion).CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setStrokeColor:))];
}

- (DTColorPicker)dt_fillColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_strokeColorPicker));
}

- (void)setQb_fillColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_fillColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.fillColor = picker(self.dt_manager.themeVersion).CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setFillColor:))];
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
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setStrokeColor:)) ]) {
                                 [self setStrokeColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setFillColor:)) ]) {
                                 [self setFillColor:result];
                             }
#pragma clang diagnostic pop
                         }];
    }];
}

@end

