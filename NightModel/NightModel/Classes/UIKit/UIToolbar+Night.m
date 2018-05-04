
#import "UIToolbar+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UIToolbar ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UIToolbar (Night)

- (DTColorPicker)dt_barTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_barTintColorPicker));
}

- (void)dt_setBarTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_barTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.barTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setBarTintColor:"];
}

@end
