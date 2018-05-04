
#import <UIKit/UIKit.h>
#import "DTNightVersionManager.h"
#import "DTNImage.h"
#import "DTNAlpha.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Night)

- (instancetype)dt_initWithImagePicker:(DTImagePicker)picker;

@property (nullable, nonatomic, copy, setter = dt_setImagePicker:) DTImagePicker dt_imagePicker;

@property (nonatomic, copy, setter = dt_setAlphaPicker:) DTAlphaPicker dt_alphaPicker;

@end

NS_ASSUME_NONNULL_END
