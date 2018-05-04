
#import "UIImageView+DTNBaseNightModel.h"
#import <objc/runtime.h>
#import "DTNightVersion.h"

@implementation UIImageView (DTNBaseNightModel)

- (NSString *)imgName4N{
    return objc_getAssociatedObject(self, @selector(imgName4N));
}

- (void)setImgName4N:(NSString *)imgName4N{
    self.dt_imagePicker = DTImagePickerWithKey(imgName4N);
}
@end
