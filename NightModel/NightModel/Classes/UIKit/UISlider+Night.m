
#import "UISlider+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UISlider ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UISlider (Night)

- (DTColorPicker)dt_minimumTrackTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_minimumTrackTintColorPicker));
}

- (void)dt_setMinimumTrackTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_minimumTrackTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.minimumTrackTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setMinimumTrackTintColor:"];
}

- (DTColorPicker)dt_maximumTrackTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_maximumTrackTintColorPicker));
}

- (void)dt_setMaximumTrackTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_maximumTrackTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.maximumTrackTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setMaximumTrackTintColor:"];
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
