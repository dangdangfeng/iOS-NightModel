
#import "UINavigationBar+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UINavigationBar ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UINavigationBar (Night)

- (DTColorPicker)dt_barTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_barTintColorPicker));
}

- (void)dt_setBarTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_barTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.barTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setBarTintColor:"];
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
