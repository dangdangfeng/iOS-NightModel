
#import "UIPageControl+Night.h"
#import "DTNightVersionManager.h"
#import <objc/runtime.h>

@interface UIPageControl ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation UIPageControl (Night)

- (DTColorPicker)dt_pageIndicatorTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_pageIndicatorTintColorPicker));
}

- (void)dt_setPageIndicatorTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_pageIndicatorTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.pageIndicatorTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setPageIndicatorTintColor:"];
}

- (DTColorPicker)dt_currentPageIndicatorTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dt_currentPageIndicatorTintColorPicker));
}

- (void)dt_setCurrentPageIndicatorTintColorPicker:(DTColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dt_currentPageIndicatorTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.currentPageIndicatorTintColor = picker(self.dt_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setCurrentPageIndicatorTintColor:"];
}

@end
