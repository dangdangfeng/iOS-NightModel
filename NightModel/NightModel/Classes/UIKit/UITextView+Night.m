
#import "UITextView+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UITextView (Night)

- (DTColorPicker)dt_textColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_textColorPicker));
}

- (void)dt_setTextColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_textColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.textColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setTextColor:"];
}

@end
