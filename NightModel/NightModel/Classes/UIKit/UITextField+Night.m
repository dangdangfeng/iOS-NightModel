
#import "UITextField+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UITextField ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UITextField (Night)

- (DTColorPicker)dt_textColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_textColorPicker));
}

- (void)dt_setTextColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_textColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.textColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setTextColor:"];
}

@end
