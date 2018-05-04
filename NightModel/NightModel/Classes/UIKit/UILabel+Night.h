
#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UILabel (Night)

@property (nonatomic, copy, setter = dt_setTextColorPicker:) DTColorPicker dt_textColorPicker;
@property (nonatomic, copy, setter = dt_setShadowColorPicker:) DTColorPicker dt_shadowColorPicker;
@property (nonatomic, copy, setter = dt_setHighlightedTextColorPicker:) DTColorPicker dt_highlightedTextColorPicker;

@end
