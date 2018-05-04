
#import "UILabel+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UILabel ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UILabel (Night)

- (DTColorPicker)dt_textColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_textColorPicker));
}

- (void)dt_setTextColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_textColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.textColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setTextColor:"];
}

- (DTColorPicker)dt_shadowColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_shadowColorPicker));
}

- (void)dt_setShadowColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_shadowColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.shadowColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setShadowColor:"];
}

- (DTColorPicker)dt_highlightedTextColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_highlightedTextColorPicker));
}

- (void)dt_setHighlightedTextColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_highlightedTextColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.highlightedTextColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setHighlightedTextColor:"];
}

@end
