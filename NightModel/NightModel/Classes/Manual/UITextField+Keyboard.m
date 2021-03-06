
#import "UITextField+Keyboard.h"
#import "NSObject+Night.h"
#import <objc/runtime.h>

@interface NSObject ()

- (void)night_updateColor;

@end


@implementation UITextField (Keyboard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(init);
        SEL swizzledSelector = @selector(dt_init);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (instancetype)dt_init {
    UITextField *obj = [self dt_init];
    if (self.dt_manager.supportsKeyboard && [self.dt_manager.themeVersion isEqualToString:DTThemeVersionNight]) {
#ifdef __IPHONE_7_0
        obj.keyboardAppearance = UIKeyboardAppearanceDark;
#else
        obj.keyboardAppearance = UIKeyboardAppearanceAlert;
#endif
    } else {
        obj.keyboardAppearance = UIKeyboardAppearanceDefault;
    }
    return obj;
}

- (void)night_updateColor {
    [super night_updateColor];
    if (self.dt_manager.supportsKeyboard && [self.dt_manager.themeVersion isEqualToString:DTThemeVersionNight]) {
#ifdef __IPHONE_7_0
        self.keyboardAppearance = UIKeyboardAppearanceDark;
#else
        self.keyboardAppearance = UIKeyboardAppearanceAlert;
#endif
    } else {
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
    }
}

@end
