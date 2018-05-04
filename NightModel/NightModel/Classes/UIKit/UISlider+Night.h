
#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UISlider (Night)

@property (nonatomic, copy, setter = dt_setMinimumTrackTintColorPicker:) DTColorPicker dt_minimumTrackTintColorPicker;
@property (nonatomic, copy, setter = dt_setMaximumTrackTintColorPicker:) DTColorPicker dt_maximumTrackTintColorPicker;
@property (nonatomic, copy, setter = dt_setThumbTintColorPicker:) DTColorPicker dt_thumbTintColorPicker;

@end
