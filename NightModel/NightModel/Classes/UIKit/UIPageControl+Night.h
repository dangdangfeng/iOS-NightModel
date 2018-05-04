
#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UIPageControl (Night)

@property (nonatomic, copy, setter = dt_setPageIndicatorTintColorPicker:) DTColorPicker dt_pageIndicatorTintColorPicker;
@property (nonatomic, copy, setter = dt_setCurrentPageIndicatorTintColorPicker:) DTColorPicker dt_currentPageIndicatorTintColorPicker;

@end
