
#import "UITableView+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UITableView (Night)

- (DTColorPicker)dt_separatorColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_separatorColorPicker));
}

- (void)dt_setSeparatorColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_separatorColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.separatorColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setSeparatorColor:"];
}

- (DTColorPicker)dt_sectionIndexColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_sectionIndexColorPicker));
}

- (void)dt_setSectionIndexColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_sectionIndexColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.sectionIndexColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setSectionIndexColor:"];
}

- (DTColorPicker)dt_sectionIndexBackgroundColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_sectionIndexBackgroundColorPicker));
}

- (void)dt_setSectionIndexBackgroundColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_sectionIndexBackgroundColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.sectionIndexBackgroundColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setSectionIndexBackgroundColor:"];
}

- (DTColorPicker)dt_sectionIndexTrackingBackgroundColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_sectionIndexTrackingBackgroundColorPicker));
}

- (void)dt_setSectionIndexTrackingBackgroundColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_sectionIndexTrackingBackgroundColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.sectionIndexTrackingBackgroundColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setSectionIndexTrackingBackgroundColor:"];
}

@end
