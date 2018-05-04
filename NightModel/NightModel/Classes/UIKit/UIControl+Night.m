
#import "UIControl+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UIControl ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UIControl (Night)

- (DTColorPicker)dt_tintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_tintColorPicker));
}

- (void)dt_setTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_tintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.tintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setTintColor:"];
}

@end
