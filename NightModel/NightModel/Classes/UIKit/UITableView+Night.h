
#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UITableView (Night)

@property (nonatomic, copy, setter = dt_setSeparatorColorPicker:) DTColorPicker dt_separatorColorPicker;
@property (nonatomic, copy, setter = dt_setSectionIndexColorPicker:) DTColorPicker dt_sectionIndexColorPicker;
@property (nonatomic, copy, setter = dt_setSectionIndexBackgroundColorPicker:) DTColorPicker dt_sectionIndexBackgroundColorPicker;
@property (nonatomic, copy, setter = dt_setSectionIndexTrackingBackgroundColorPicker:) DTColorPicker dt_sectionIndexTrackingBackgroundColorPicker;

@end
