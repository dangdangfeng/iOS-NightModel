
#import "UIImageView+Night.h"
#import "NSObject+Night.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UIImageView (Night)

- (instancetype)dt_initWithImagePicker:(DTImagePicker)picker {
    UIImageView *imageView = [self initWithImage:picker(self.dt_manager.themeVersion)];
    imageView.dt_imagePicker = [picker copy];
    return imageView;
}

- (DTImagePicker)dt_imagePicker {
    return objc_getAssociatedObject(self, @selector(dt_imagePicker));
}

- (void)dt_setImagePicker:(DTImagePicker)picker {
    objc_setAssociatedObject(self, @selector(dt_imagePicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.image = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setImage:"];
}

- (DTAlphaPicker)dt_alphaPicker {
    return objc_getAssociatedObject(self, @selector(dt_alphaPicker));
}

- (void)dt_setAlphaPicker:(DTAlphaPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_alphaPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.alpha = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setAlpha:"];
}

- (void)night_updateColor {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"setAlpha:"]) {
            DTAlphaPicker picker = (DTAlphaPicker)obj;
            CGFloat alpha = picker(self.dt_manager.themeVersion);
            [UIView animateWithDuration:DTNightVersionAnimationDuration
                             animations:^{
                                 ((void (*)(id, SEL, CGFloat))objc_msgSend)(self, NSSelectorFromString(key), alpha);
                             }];
        } else {
            SEL sel = NSSelectorFromString(key);
            DTColorPicker picker = (DTColorPicker)obj;
            UIColor *resultColor = picker(self.dt_manager.themeVersion);
            [UIView animateWithDuration:DTNightVersionAnimationDuration
                             animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                 [self performSelector:sel withObject:resultColor];
#pragma clang diagnostic pop
                             }];
            
        }
    }];
}

@end
