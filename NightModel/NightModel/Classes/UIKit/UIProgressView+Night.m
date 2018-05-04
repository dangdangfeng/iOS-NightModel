
#import "UIProgressView+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UIProgressView ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UIProgressView (Night)

- (DTColorPicker)dt_progressTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_progressTintColorPicker));
}

- (void)dt_setProgressTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_progressTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.progressTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setProgressTintColor:"];
}

- (DTColorPicker)dt_trackTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_trackTintColorPicker));
}

- (void)dt_setTrackTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_trackTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.trackTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setTrackTintColor:"];
}

@end
