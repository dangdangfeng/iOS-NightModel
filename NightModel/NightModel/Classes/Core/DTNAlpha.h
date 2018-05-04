
#import <UIKit/UIKit.h>
#import "DTNightType.h"

typedef CGFloat (^DTAlphaPicker)(DTThemeVersion *themeVersion);

DTAlphaPicker DTAlphaPickerWithAlphas(CGFloat normal, ...);

// 默认Alpha规则，正常为0
DTAlphaPicker DTAlphaPickerWithKey(CGFloat night);

@interface DTNAlpha : NSObject

+ (DTAlphaPicker)alphaPickerWithAlpha:(CGFloat)alpha;

@end
