
#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UIView (Night)

@property (nonatomic, copy, setter = dt_setBackgroundColorPicker:) DTColorPicker dt_backgroundColorPicker;
@property (nonatomic, copy, setter = dt_setTintColorPicker:) DTColorPicker dt_tintColorPicker;

@end
