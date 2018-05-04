
#import <QuartzCore/QuartzCore.h>
#import "NSObject+Night.h"
#import "DTNightType.h"

@interface CALayer (Night)

@property (nonatomic, copy) DTColorPicker dt_shadowColorPicker;
@property (nonatomic, copy) DTColorPicker dt_borderColorPicker;
@property (nonatomic, copy) DTColorPicker dt_backgroundColorPicker;

@end
