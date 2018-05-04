
#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UINavigationBar (Night)

@property (nonatomic, copy, setter = dt_setBarTintColorPicker:) DTColorPicker dt_barTintColorPicker;
@property (nonatomic, copy, setter = dt_setTintColorPicker:) DTColorPicker dt_tintColorPicker;

@end
