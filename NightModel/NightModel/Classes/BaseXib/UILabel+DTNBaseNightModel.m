
#import "UILabel+DTNBaseNightModel.h"
#import "DTNightVersion.h"
#import <objc/runtime.h>

@implementation UILabel (DTNBaseNightModel)
- (NSString *)titleC4N{
    return objc_getAssociatedObject(self, @selector(titleC4N));
}

- (void)setTitleC4N:(NSString *)titleC4N{
    self.dt_textColorPicker = DTColorPickerWithKey(titleC4N);
}
@end
