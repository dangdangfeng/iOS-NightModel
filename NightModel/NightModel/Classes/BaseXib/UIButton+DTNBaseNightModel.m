
#import "UIButton+DTNBaseNightModel.h"
#import "DTNightVersion.h"
#import <objc/runtime.h>

@implementation UIButton (DTNBaseNightModel)

- (NSString *)titleC4N{
    return objc_getAssociatedObject(self, @selector(titleC4N));
}
- (void)setTitleC4N:(NSString *)titleC4N{
    [self dt_setTitleColorPicker:DTColorPickerWithKey(titleC4N) forState:UIControlStateNormal];
}

- (NSString *)imgName4N{
    return objc_getAssociatedObject(self, @selector(imgName4N));
}
- (void)setImgName4N:(NSString *)imgName4N{
    [self dt_setImage:DTImagePickerWithKey(imgName4N) forState:UIControlStateNormal];
}

@end
