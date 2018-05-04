
#import "UIView+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UIView (Night)

- (DTColorPicker)dt_backgroundColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_backgroundColorPicker));
}

- (void)dt_setBackgroundColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_backgroundColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.backgroundColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setBackgroundColor:"];
}

- (DTColorPicker)dt_tintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_tintColorPicker));
}

- (void)dt_setTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_tintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.tintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setTintColor:"];
}

@end
