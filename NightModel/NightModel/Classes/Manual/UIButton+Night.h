
#import <UIKit/UIKit.h>
#import "NSObject+Night.h"
#import "DTNImage.h"

@interface UIButton (Night)

- (void)dt_setTitleColorPicker:(DTColorPicker)picker forState:(UIControlState)state;

- (void)dt_setBackgroundImage:(DTImagePicker)picker forState:(UIControlState)state;

- (void)dt_setImage:(DTImagePicker)picker forState:(UIControlState)state;

@end
