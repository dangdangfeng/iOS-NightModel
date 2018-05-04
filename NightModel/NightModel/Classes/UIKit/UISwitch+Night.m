
#import "UISwitch+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UISwitch ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UISwitch (Night)

- (DTColorPicker)dt_onTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_onTintColorPicker));
}

- (void)dt_setOnTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_onTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.onTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setOnTintColor:"];
}

- (DTColorPicker)dt_thumbTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_thumbTintColorPicker));
}

- (void)dt_setThumbTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_thumbTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.thumbTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setThumbTintColor:"];
}

@end
